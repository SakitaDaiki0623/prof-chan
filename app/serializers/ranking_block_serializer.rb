# app/serializers/ranking_block_serializer.rb
class RankingBlockSerializer < ApplicationSerializer
  attributes :id, :title, :first_place, :second_place, :third_place, :owing_user
  belongs_to :profile_block, serializer: ProfileBlockSerializer
  has_many :ranking_block_likes
  has_many :users, through: :ranking_block_likes
end
