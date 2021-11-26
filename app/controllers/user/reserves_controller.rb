class User::ReservesController < ApplicationController
  include User::MessagesHelper
  include User::NotificationsHelper

  before_action :set_recruit
  before_action :confirm_access_restrictions, only: [:confirm, :complete]

  def create
    @reserve = Reserve.create(user_id: current_user.id, recruit_id: @recruit.id)
    # 予約時に予約ステータスを返信待ちに更新
    @reserve.update_attributes(reserve_status: "wait_reserve")
    # 予約されたことを投稿主に通知する
    create_notification(current_user,
                        @recruit.user,
                        @recruit.id,
                        nil,
                        nil,
                        nil,
                        "reserve")
  end

  def destroy
    @reserve = Reserve.find_by(user_id: current_user.id, recruit_id: @recruit.id)
    @reserve.destroy
    # 予約キャンセルされたことを投稿主に通知する
    create_notification(current_user,
                        @recruit.user,
                        @recruit.id,
                        nil,
                        nil,
                        nil,
                        "cancel")
  end

  def update
    @reserve = Reserve.find(params[:id])
    status = params[:status]
    case status
      when "approve_reserve" then
        # 承認ボタン押下時に予約ステータスを承認に更新
        @reserve.update_attributes(reserve_status: "approve_reserve")
      when "reject_reserve" then
        # 拒否ボタン押下時に予約ステータスを拒否に更新
        @reserve.update_attributes(reserve_status: "reject_reserve")
    end

    @reserves = @recruit.reserves
    reserves_count = @reserves.where(reserve_status: "approve_reserve").count

    few_remain = (@recruit.capacity * 0.5).floor
    last_remain = (@recruit.capacity * 0.9).floor

    # 予約数が募集人員の5～9割以内に到達した時に募集ステータスを"残り僅か"に更新
    if (reserves_count > few_remain) && (reserves_count <= last_remain)
      @recruit.update_attributes(recruit_status: "few_recruit")
    elsif reserves_count <= @recruit.capacity
      @recruit.update_attributes(recruit_status: "now_recruit")
    end
  end

  def waiting
    @reserves = @recruit.reserves.includes(:user)
  end

  def confirm
    @reserves = Reserve.where(recruit_id: @recruit.id, reserve_status: "approve_reserve")
  end

  def complete
    @reserves = Reserve.where(recruit_id: @recruit.id, reserve_status: "approve_reserve")
    @reject_reserves = Reserve.where(recruit_id: @recruit.id, reserve_status: "reject_reserve")
    # 募集ステータスを募集終了に更新
    @recruit.update_attributes(recruit_status: "end_recruit")
    @reserves.each do |reserve|
      # 予約ステータスを予約確定に更新
      reserve.update_attributes(reserve_status: "confirm_reserve")
      user = reserve.user
      server_link = text_url_to_link(reserve.recruit.discord_server_link)
      message = "サーバー招待を送信します\nご入室ください\n#{server_link}"
      # 予約確定時に全参加者にサーバーリンクを送信する
      room_create_search(current_user, user, message, "broadcast")
    end
    if @reject_reserves.present?
      @reject_reserves.each do |reserve|
        user = reserve.user
        message = "予約が拒否されました\nまたの機会にご利用ください"
        # 予約確定時に予約拒否した相手に拒否した旨を送信する
        room_create_search(current_user, user, message, "broadcast")
      end
      # 予約確定時に拒否したユーザーの予約を削除する
      @reject_reserves.destroy_all
    end
    # 予約確定時に投稿主のレベルアップ
    Experience.level_up(current_user)
  end

  private

  def set_recruit
    @recruit = Recruit.find(params[:recruit_id])
  end

  def confirm_access_restrictions
    # 募集ステータスが募集終了の場合、confirm・completeページにアクセスできないように制限
    if @recruit.recruit_status == "end_recruit"
      redirect_to recruit_path(@recruit.id)
    end
  end
end
