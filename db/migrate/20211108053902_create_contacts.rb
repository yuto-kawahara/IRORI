class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.integer :user_id, null: false
      t.string  :subject, null: false
      t.text    :message, null: false
      t.timestamps
    end
  end
end
