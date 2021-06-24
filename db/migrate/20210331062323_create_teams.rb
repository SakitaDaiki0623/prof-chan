class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :workspace_id,     null: false
      t.string :share_channel_id, null: false
      t.string :share_channel_name, null: false
      t.string :domain, null: false
      t.integer :share_right, null: false, default: 0
      t.string :image, null: false
      t.timestamps
    end

    add_index :teams, [:workspace_id],                      unique: true
    add_index :teams, [:share_channel_id, :workspace_id],   unique: true
  end
end
