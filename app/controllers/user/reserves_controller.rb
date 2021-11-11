class User::ReservesController < ApplicationController
  include User::MessagesHelper
  include User::NotificationsHelper

  before_action :set_recruit
  before_action :confirm_access_restrictions, only: [:confirm, :complete]

  def create
    @reserve = @recruit.reserves.create(user_id: current_user.id)
    @reserve.update_attributes(reserve_status: "wait_reserve")
    create_notification(current_user,
                        @recruit.user,
                        @recruit.id,
                        nil,
                        nil,
                        nil,
                        "reserve")
  end

  def destroy
    reserve = @recruit.reserves.find_by(user_id: current_user.id)
    reserve.destroy
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
    @reserves = @recruit.reserves

    remain_few = (@recruit.capacity * 0.7).floor
    remain_last = (@recruit.capacity * 0.9).floor

    if (@reserves.count >= remain_few) && (@reserves.count <= remain_last)
      @recruit.update_attributes(recruit_status: "few_recruit")
    end

    status = params[:status]
    case status
      when "approve_reserve" then
        @reserve.update_attributes(reserve_status: "approve_reserve")
        @active = "active"
      when "reject_reserve" then
        @reserve.update_attributes(reserve_status: "reject_reserve")
        @active = "no_active"
    end
  end

  def waiting
    @reserves = @recruit.reserves
  end

  def confirm
    @reserves = Reserve.where(recruit_id: @recruit.id, reserve_status: "approve_reserve")
  end

  def complete
    @reserves = Reserve.where(recruit_id: @recruit.id, reserve_status: "approve_reserve")
    @recruit.update_attributes(recruit_status: "end_recruit")
    @reserves.each do |reserve|
      user = reserve.user
      server_link = text_url_to_link(reserve.recruit.discord_server_link)
      message = "サーバー招待を送信します\nご入室ください\n#{server_link}"

      room_create_search(current_user, user, message, "broadcast")
    end
  end

  private

  def set_recruit
    @recruit = Recruit.find(params[:recruit_id])
  end

  def confirm_access_restrictions
    if @recruit.recruit_status == "end_recruit"
      redirect_to reserve_list_recruit_path(@recruit.id)
    end
  end
end
