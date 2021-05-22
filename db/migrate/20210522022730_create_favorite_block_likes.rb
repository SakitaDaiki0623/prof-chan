class CreateFavoriteBlockLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_block_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :favorite_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
