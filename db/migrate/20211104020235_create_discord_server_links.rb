class CreateDiscordServerLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :discord_server_links do |t|
      t.integer :user_id,  null: false
      t.string  :name,     null: false, default: ""
      t.string  :link,     null: false, default: ""
      t.timestamps
    end
  end
end
