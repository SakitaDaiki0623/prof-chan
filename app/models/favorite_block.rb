class FavoriteBlock < ApplicationRecord
  belongs_to :profile_block

  # validation =============
  validates :text, presence: true,      length: { maximum: 20 }
end
