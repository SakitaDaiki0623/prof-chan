class AddPrfilesToUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :height, null: false
      t.integer :gender, null: false
      t.integer :blood_type, null: false
      t.integer :prefecture_id, null: false
      t.datetime :birthday, null: false
      t.datetime :day_of_joinning, null: false
      t.string :public_uid, null: false

      t.timestamps
    end

    add_index :profiles, :public_uid, unique: true
  end
end