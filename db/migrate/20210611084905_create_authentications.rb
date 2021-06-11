class CreateAuthentications < ActiveRecord::Migration[6.0]
  def change
    create_table :authentications do |t|
      t.json :access_token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
