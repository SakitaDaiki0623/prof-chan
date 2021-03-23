class RemoveTeamIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :team_id, :string
  end
end
