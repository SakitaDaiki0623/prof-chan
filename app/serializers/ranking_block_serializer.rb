# app/serializers/ranking_block_serializer.rb
class RankingBlockSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many   :ranking_items,  serializer: RankingItemSerializer
  belongs_to :profile_block,   serializer: ProfileBlockSerializer
end
