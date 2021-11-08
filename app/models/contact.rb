class Contact < ApplicationRecord
  belongs_to :user

  validates :subject, presence: true, length: { maximum: 100 }
  validates :message, presence: true, length: { maximum: 1000 }
end
