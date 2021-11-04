class DiscordServerLink < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 100 }
  validates :link, presence: true, length: { maximum: 200 }
end
