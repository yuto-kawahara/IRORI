class CreateRecruitPlayForms < ActiveRecord::Migration[5.2]
  def change
    create_table :recruit_play_forms do |t|
      t.integer :recruit_id,    null: false, default: ""
      t.integer :play_form_id,  null: false, default: ""
      t.timestamps
    end
  end
end
