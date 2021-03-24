class ChangeColumnsAddNotnullOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :slack_credential_token, :string, null: false
    change_column :users, :uid, :string, null: false
    change_column :users, :provider, :string, null: false
  end
end
