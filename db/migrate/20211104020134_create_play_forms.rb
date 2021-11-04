class CreatePlayForms < ActiveRecord::Migration[5.2]
  def change
    create_table :play_forms do |t|
      t.string :name,               null: false, default: ""
      t.text   :introduction,       null: false, default: ""
      t.timestamps
    end
  end
end
