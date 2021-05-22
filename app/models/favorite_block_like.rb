class FavoriteBlockLike < ApplicationRecord
  belongs_to :user
  belongs_to :favorite_block

  scope :filter_by_favorite_block, ->(favorite_block_id) { where(favorite_block_id: favorite_block_id) if favorite_block_id }
end
