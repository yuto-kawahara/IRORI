class Recruit < ApplicationRecord
  scope :valid,  -> { where(user_id: User.valid) }
  scope :following_user_recruit, -> (user) { where(user_id: [user.id, user.following_user.valid] ) }
  scope :status, -> (status)  { where(recruit_status: status ) }
  scope :sorted, -> { order(created_at: :desc ) }
  scope :closed, -> { where(recruit_status: "end_recruit") }

  belongs_to :user
  has_many   :recruit_play_forms,       dependent: :destroy
  has_many   :play_forms,               through:   :recruit_play_forms
  has_many   :recruit_entry_conditions, dependent: :destroy
  has_many   :entry_conditions,         through:   :recruit_entry_conditions
  has_many   :reserves,                 dependent: :destroy
  has_many   :recruit_comments,         dependent: :destroy
  has_many   :notifications,            dependent: :destroy

  attachment :image
  validates :title,               presence: true, length: { maximum: 200 }
  validates :start_time,          presence: true
  validates :capacity,            presence: true
  validates :time_required,       presence: true
  validates :explanation,         length: { maximum: 1000 }
  validates :discord_server_link, presence: true, length: { maximum: 200 }

  enum recruit_status:{
    not_recruit:      0,     #未募集
    now_recruit:      1,     #募集中
    few_recruit:      2,     #残り僅か
    end_recruit:      3,     #募集終了
    reminded_recruit: 4      #募集リマインド完了
  }

  def reserve_exist?(user)
    reserves.where(user_id: user.id).exists?
  end

  def self.remind_user
    @recruits = Recruit.where(recruit_status: "end_recruit")
    if @recruits.present?
      @recruits.each do |recruit|
        # 募集日時の前日のAM8:00にリマインドを一斉送信
        if ((recruit.start_time - 1) < Time.current)
          reserves = recruit.reserves
          reserves.each do |reserve|
            message = "「#{recruit.title}」の前日リマインドです。\nサーバーにまだ入室していない場合は入室してください。"
            User::MessagesController.helpers.room_create_search(recruit.user, reserve.user, message, "broadcast")
          end
          recruit.update_attributes(recruit_status: "reminded_recruit")
        end
      end
    end
  end
end
