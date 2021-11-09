class User < ApplicationRecord
  scope :valid,  -> { where(user_status: "valid_user") }
  scope :sorted, -> { order(created_at: :desc ) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable#, :validatable

  has_many :recruits,              dependent: :destroy
  has_many :recruit_comments,      dependent: :destroy
  has_many :reserves,              dependent: :destroy
  has_many :messages,              dependent: :destroy
  has_many :user_rooms,            dependent: :destroy
  has_many :rooms,                 through: :user_rooms
  has_many :discord_server_links,  dependent: :destroy
  has_many :contacts,              dependent: :destroy

  has_many :following,             class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followed,              class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user,        through: :following, source: :followed
  has_many :follower_user,         through: :followed,  source: :following

  has_many :active_notifications,  class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  attachment :icon_image
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 300 }

  enum user_status:{
    valid_user: 0,   #有効
    quit_user:  1    #退会
  }

  def follow(user)
    following.create(followed_id: user.id)
  end

  def unfollow(user)
    following.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  def to_param
    nickname
  end

  def self.included(base)
    base.extend ClassMethods
    assert_validations_api!(base)

    base.class_eval do
      validates_uniqueness_of :email, scope: :user_status
      validates_presence_of   :email, if: :email_required?
      validates_format_of     :email, with: email_regexp, allow_blank: true, if: :email_changed?

      validates_presence_of     :password, if: :password_required?
      validates_confirmation_of :password, if: :password_required?
      validates_length_of       :password, within: password_length, allow_blank: true
    end
  end
end
