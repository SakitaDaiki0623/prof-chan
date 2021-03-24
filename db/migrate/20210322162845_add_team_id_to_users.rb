class AddTeamIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index     :users, :uid, unique: true
  end
end
