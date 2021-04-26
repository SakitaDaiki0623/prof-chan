# app/serializers/ranking_block_serializer.rb
class RankingBlockSerializer < ActiveModel::Serializer
  attributes :id, :title, :first_place, :second_place, :third_place
  belongs_to :profile_block, serializer: ProfileBlockSerializer
end
