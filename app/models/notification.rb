class Notification < ApplicationRecord
  scope :unread, -> { where(checked: false ) }
  scope :sorted, -> { order(created_at: :desc ) }

  belongs_to :recruit,         optional: true
  belongs_to :recruit_comment, optional: true
  belongs_to :message,         optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
