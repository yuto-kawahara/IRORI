class CreateRecruitComments < ActiveRecord::Migration[5.2]
  def change
    create_table :recruit_comments do |t|
      t.integer    :user_id,      null: false, default: ""
      t.integer    :recruit_id,   null: false, default: ""
      t.text       :comment,      null: false
      t.timestamps
    end
  end
end
