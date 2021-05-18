class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table(:users) do |t|

      t.string :provider, null: false, :default => "email"
      t.string :uid

      ## Database authenticatable
      t.string :encrypted_password, null: false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      t.string :name, null: false
      t.string :image, null: false
      t.string :email, null: false
      t.references :team, foreign_key: true, :default => "1"

      ## Tokens
      t.timestamps
    end

    add_index :users, :email,                unique: true
    # add_index :users, :unlock_token,         unique: true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
