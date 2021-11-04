class EntryCondition < ApplicationRecord
  has_many :recruit_entry_conditions, dependent: :destroy
  has_many :recruits,                 through: :recruit_entry_conditions
end
