class User < ApplicationRecord
  BRONZE_LEVEL   = 10  # ブロンズ会員
  SILVER_LEVEL   = 30  # シルバー会員
  GOLD_LEVEL     = 50  # ゴールド会員

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
  has_many :experiences,           dependent: :destroy

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

  def level
    level = Experience.find_or_create_by!(user_id: id).level
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
    user = User.find_by(user_status: "guest_user")
    if user.present?
      user.destroy
    end
  end

  # 未読の通知がある場合は既読に更新
  def notification_checked
    passive_notifications.valid.unread.each{ |notification| notification.update_attribute(:checked, true) }
  end

  # ユーザーの論理削除
  def logical_delete!
    # deviseの一意制約を回避するため退会時にユーザー名とメールアドレスに退会用の文字列付与
    assign_attributes(nickname: nickname + quited_suffix,
                      email: email + quited_suffix,
                      user_status: "quit_user")
    skip_email_changed_notification!
    save!
  end

  # 接尾辞に退会用の文字列を生成
  def quited_suffix
    "_quited_user_" + I18n.l(Time.current, format: :long)
  end

  # ゲスト退会時の初期化処理
  def reset_guest
    update_attributes(nickname: "ゲスト",
                      email: "guest@example.com",
                      icon_image: nil,
                      introduction: nil)
  end
end
