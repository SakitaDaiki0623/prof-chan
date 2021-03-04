# db/migrate/20210304060149_create_profiles.rb
class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :birthday, null: false
      t.text :introduction
      t.integer :height, null: false
      t.integer :gender, null: false
      t.datetime :day_of_joinning, null: false

      t.timestamps
    end
  end
end
