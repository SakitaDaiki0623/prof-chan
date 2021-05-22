class FavoriteBlockLike < ApplicationRecord
  belongs_to :user
  belongs_to :favorite_block
  has_many :favorite_block_likes, dependent: :destroy
  has_many :users, through: :favorite_block_likes

  scope :filter_by_favorite_block, ->(favorite_block_id) { where(favorite_block_id: favorite_block_id) if favorite_block_id }
end
