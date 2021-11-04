class CreateEntryConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_conditions do |t|
      t.string :name,               null: false
      t.text   :introduction,       null: false, default: ""
      t.timestamps
    end
  end
end
