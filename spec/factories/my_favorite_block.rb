# manga_anime
# game_app
# character
# entertainer
# musician
# music
# food
# animal
# sports
# book
# place
# snack
# alcohol_drink
# restaurants
# youtuber
# actor

# spec/factories/my_favorite_block.rb
FactoryBot.define do
  factory :my_favorite_block do
    manga_anime { 'a' * 10 }
    game_app { 'a' * 10 }
    character { 'a' * 10 }
    entertainer { 'a' * 10 }
    musician { 'a' * 10 }
    music { 'a' * 10 }
    food { 'a' * 10 }
    animal { 'a' * 10 }
    sports { 'a' * 10 }
    book { 'a' * 10 }
    place { 'a' * 10 }
    snack { 'a' * 10 }
    alcohol_drink { 'a' * 10 }
    restaurants { 'a' * 10 }
    youtuber { 'a' * 10 }
    association :profile_block
  end
end
