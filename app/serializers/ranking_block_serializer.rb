# app/serializers/ranking_block_serializer.rb
class RankingBlockSerializer < ActiveModel::Serializer
  attributes :id, :title
  belongs_to :profile_block,   serializer: ProfileBlockSerializer
end
