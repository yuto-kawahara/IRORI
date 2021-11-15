class RecruitPlayForm < ApplicationRecord
  belongs_to :recruit
  belongs_to :play_form

  def self.bulk_create(recruit_id, ids)
    ids.each do |id|
      if where(recruit_id: recruit_id, play_form_id: id).blank?
        create(recruit_id: recruit_id, play_form_id: id)
      end
    end
  end
end
