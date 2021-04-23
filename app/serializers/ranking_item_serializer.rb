# app/serializers/ranking_item_serializer.rb
class RankingItemSerializer < ActiveModel::Serializer
  attributes :id, :content, :answer, :ranking_block
  belongs_to :ranking_block, serializer: RankingBlockSerializer

  def ranking_block
    object.ranking_block
  end
end
