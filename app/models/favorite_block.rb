class FavoriteBlock < ApplicationRecord
  belongs_to :profile_block
  has_many :favorite_block_likes, dependent: :destroy
  has_many :users, through: :favorite_block_likes

  validates :text, presence: true, length: { maximum: 20 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
end
