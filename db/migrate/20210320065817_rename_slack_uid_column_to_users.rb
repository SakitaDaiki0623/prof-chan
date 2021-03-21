class RenameSlackUidColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :slack_uid, :uid
  end
end
