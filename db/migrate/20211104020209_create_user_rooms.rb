class CreateUserRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_rooms do |t|
      t.integer :user_id, null: false, default: ""
      t.integer :room_id, null: false, default: ""
      t.timestamps
    end
  end
end
