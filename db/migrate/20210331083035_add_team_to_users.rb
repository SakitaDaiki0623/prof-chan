class AddTeamToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :team, null: false, foreign_key: true
  end
end
