class CreateExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :experiences do |t|
      t.integer    :user_id,      null: false
      t.integer    :level,        null: false, default: 0
      t.timestamps
    end
  end
end
