class Reserve < ApplicationRecord
  scope :status, -> (status)  { where(reserve_status: status ) }

  belongs_to :user
  belongs_to :recruit
  counter_culture :recruit
end
