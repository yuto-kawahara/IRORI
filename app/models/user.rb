class User < ApplicationRecord
  scope :valid,  -> { where(user_status: ["valid_user", "guest_user"]) }
  scope :sorted, -> { order(created_at: :desc) }
  scope :not_current, -> (user) { where.not(id: user.id) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  has_many :reviewer,              class_name: 'Evaluation', foreign_key: 'reviewer_id', dependent: :destroy
  has_many :reviewee,              class_name: 'Evaluation', foreign_key: 'reviewee_id', dependent: :destroy

  attachment :icon_image
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 300 }

  enum user_status: {
    valid_user: 0,   # 有効
    quit_user:  1,   # 退会
    guest_user: 2    # ゲストユーザー
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

  # ゲストログイン時にまだゲストユーザーが作成されていない場合は作成し、
  # ゲストユーザーが作成されている場合はそのままログインする
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.nickname = 'ゲスト'
      user.password = SecureRandom.urlsafe_base64
      user.user_status = "guest_user"
    end
  end

  # 毎日0:00にゲストユーザーを削除する
  def self.guest_delete
    user = User.where(email: 'guest@example.com')
    if user.present?
      user.destroy_all
    end
  end

end
