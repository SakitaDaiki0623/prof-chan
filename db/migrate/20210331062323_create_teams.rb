class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :workspace_id, null: false
      t.index :workspace_id, unique: true
      t.string :image, null: false
      t.timestamps
    end
  end
end
