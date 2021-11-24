class Experience < ApplicationRecord
  belongs_to :user

  def self.level_up(user)
    experience = find_or_create_by!(user_id: user.id)
    experience.increment!(:level, 1)
  end
end
