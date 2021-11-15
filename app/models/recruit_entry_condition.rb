class RecruitEntryCondition < ApplicationRecord
  belongs_to :recruit
  belongs_to :entry_condition

  def self.bulk_create(recruit_id, ids)
    ids.each do |id|
      if where(recruit_id: recruit_id, entry_condition_id: id).blank?
        create(recruit_id: recruit_id, entry_condition_id: id)
      end
    end
  end
end
