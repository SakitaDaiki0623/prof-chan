class CreateShareRights < ActiveRecord::Migration[6.0]
  def change
    create_table :share_rights do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :question, null: false, default: 0
      t.integer :ranking, null: false, default: 0
      t.integer :yes_or_no, null: false, default: 0
      t.integer :text, null: false, default: 0

      t.timestamps
    end
  end
end
