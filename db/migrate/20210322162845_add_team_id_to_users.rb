class AddTeamIdToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :team_id, :string, null: false
    change_column :users, :email, :string, null: false, unique: true
    change_column :users, :uid, :string, null: false, unique: true
  end
end
