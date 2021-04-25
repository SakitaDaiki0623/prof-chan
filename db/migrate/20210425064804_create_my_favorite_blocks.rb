class CreateMyFavoriteBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :my_favorite_blocks do |t|
      t.string :manga_anime
      t.string :game_app
      t.string :character
      t.string :entertainer
      t.string :musician
      t.string :music
      t.string :food
      t.string :animal
      t.string :sports
      t.string :book
      t.string :place
      t.string :snack
      t.string :alcohol_drink
      t.string :restaurants
      t.string :YouTuber
      t.string :actor

      t.references :profile_block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
