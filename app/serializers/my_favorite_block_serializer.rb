class MyFavoriteBlockSerializer < ActiveModel::Serializer
  attributes :id, :manga_anime, :game_app, :character, :actor, :entertainer, :music, :food, :animal, :sports, :book, :place, :snack, :alcohol_drink, :restaurants, :youtuber, :musician

  belongs_to :profile_block
end
