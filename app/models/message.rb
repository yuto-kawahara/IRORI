class Message < ApplicationRecord
  scope :valid,  -> { where(user_id: User.valid) }
  scope :sorted, -> { order(created_at: :desc ) }

  belongs_to :user
  belongs_to :room
  validates :content, presence: true, length: { maximum: 500 }
end
