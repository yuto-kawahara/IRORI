class Notification < ApplicationRecord
  scope :valid,  -> { where(visitor_id: User.valid) }
  scope :unread, -> { where(checked: false ) }
  scope :sorted, -> { order(created_at: :desc ) }
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  belongs_to :recruit,         optional: true
  belongs_to :recruit_comment, optional: true
  belongs_to :message,         optional: true
  belongs_to :evaluation,      optional: true
end
