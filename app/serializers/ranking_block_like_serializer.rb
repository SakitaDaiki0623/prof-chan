class RankingBlockLikeSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user
  belongs_to :ranking_block
end
