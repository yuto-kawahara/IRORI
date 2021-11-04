class CreateRecruits < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits do |t|
      # t.integer    :user_id,               null: false, default: ""
      # t.string     :title,                 null: false, default: ""
      # t.string     :image_id,              null: false, default: ""
      # t.datetime   :start_time,            null: false, default: ""
      # t.integer    :time_required,         null: false, default: ""
      # t.integer    :capacity,              null: false, default: ""
      # t.text       :explanation,           null: false
      # t.string     :discord_server_link,   null: false, default: ""
      # t.integer    :recruit_status,        null: false, default: 1
      # t.integer    :recruit_comments_count,null: false, default: 0
      # t.integer    :reserves_count,        null: false, default: 0
      # t.timestamps
    end
    # add_index :recruits, :start_time
    # add_index :recruits, :recruit_status
  end
end
