class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :following, foreign_key: { to_table: :users }, null: false, default: ""
      t.references :followed,  foreign_key: { to_table: :users }, null: false, default: ""
      t.timestamps
    end
  end
end
