class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :slack_uid, :string
    add_column :users, :image, :string
    add_column :users, :slack_credential_token, :string
    add_column :users, :team_id, :string
  end
end
