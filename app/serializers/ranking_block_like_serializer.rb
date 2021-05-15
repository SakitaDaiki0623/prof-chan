class RankingBlockLikeSerializer < ApplicationSerializer
  attributes :id
  belongs_to :user
  belongs_to :ranking_block
end
