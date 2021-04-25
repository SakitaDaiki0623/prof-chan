class MyFavoriteBlockSerializer < ActiveModel::Serializer
  attributes :id, :manga_anime, :game_app, :character, :admired_person, :entertainer, :music, :food, :animal, :sports, :book, :place, :snack, :alcohol_drink, :restaurants, :characteristic, :musician

  belongs_to :profile_block
end
