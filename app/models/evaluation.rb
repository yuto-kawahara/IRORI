class Evaluation < ApplicationRecord
  scope :sorted, -> { order(created_at: :desc ) }
  belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id', optional: true
  belongs_to :reviewee, class_name: 'User', foreign_key: 'reviewee_id', optional: true

  validates :stars,   presence: true
  validates :comment, presence: true, length: { maximum: 500 }
end
