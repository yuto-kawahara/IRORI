class UserRoom < ApplicationRecord
  scope :sorted, -> { order(created_at: :desc ) }

  belongs_to :user
  belongs_to :room
end
