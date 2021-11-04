class CreateRecruitEntryConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :recruit_entry_conditions do |t|
      t.integer :recruit_id,          null: false
      t.integer :entry_condition_id,  null: false
      t.timestamps
    end
  end
end
