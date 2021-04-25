class RankingBlockLike < ApplicationRecord
  belongs_to :user
  belongs_to :ranking_block

  scope :filter_by_ranking_block, ->(ranking_block_id) { where(ranking_block_id: ranking_block_id) if ranking_block_id }
end
