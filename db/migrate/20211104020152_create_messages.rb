class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :user_id,   null: false, default: ""
      t.integer :room_id,   null: false, default: ""
      t.text    :content,   null: false, default: ""
      t.timestamps
    end
  end
end
