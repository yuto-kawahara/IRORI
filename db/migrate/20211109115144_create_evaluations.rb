class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.integer :reviewer_id, null: false
      t.integer :reviewee_id, null: false
      t.float   :stars,       null: false
      t.text    :comment,     null: false
      t.timestamps
    end
  end
end
