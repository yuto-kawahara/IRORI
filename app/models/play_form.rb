class PlayForm < ApplicationRecord
  has_many :recruit_play_forms, dependent: :destroy
  has_many :recruits,           through: :recruit_play_forms
end
