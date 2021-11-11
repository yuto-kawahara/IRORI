class Evaluation < ApplicationRecord
  scope :valid,  -> { where(reviewer_id: User.valid) }
  scope :sorted, -> { order(created_at: :desc ) }
  scope :not_current, -> (user) { where.not(reviewer_id: user.id ) }

  belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id', optional: true
  belongs_to :reviewee, class_name: 'User', foreign_key: 'reviewee_id', optional: true
  has_many   :notifications, dependent: :destroy
  validates :stars,   presence: true
  validates :comment, presence: true, length: { maximum: 500 }
end
