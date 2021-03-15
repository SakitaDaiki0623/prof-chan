class RemoveColumnsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :crypted_password, :string
    remove_column :users, :salt, :string
    remove_column :users, :description, :string
    remove_column :users, :email, :string
  end
end
