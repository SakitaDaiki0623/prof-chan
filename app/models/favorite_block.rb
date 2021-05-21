class FavoriteBlock < ApplicationRecord
  belongs_to :profile_block

  # validation =============
  validates :text, presence: true,      length: { maximum: 20 }

  # active hash =============
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
end
