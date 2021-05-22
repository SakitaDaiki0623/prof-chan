class CreateFavoriteBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_blocks do |t|
      t.string :text
      t.integer :category_id, null: false
      t.references :profile_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
