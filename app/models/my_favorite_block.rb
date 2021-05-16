# app/models/my_favorite_block.rb
class MyFavoriteBlock < ApplicationRecord
  # association ==========
  belongs_to :profile_block

  # validation =============
  with_options length: { maximum: 15 } do
    validates :manga_anime
    validates :game_app
    validates :character
    validates :actor
    validates :entertainer
    validates :musician
    validates :music
    validates :food
    validates :animal
    validates :sports
    validates :book
    validates :place
    validates :snack
    validates :alcohol_drink
    validates :restaurants
    validates :youtuber
  end
end
