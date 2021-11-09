class UserRoom < ApplicationRecord
  scope :valid,  -> { where(user_id: User.valid) }
  scope :sorted, -> { order(created_at: :desc ) }

  belongs_to :user
  belongs_to :room
end
