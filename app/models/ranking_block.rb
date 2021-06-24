class RankingBlock < ApplicationRecord
  belongs_to :profile_block
  has_many :ranking_block_likes, dependent: :destroy
  has_many :users, through: :ranking_block_likes

  with_options presence: true do
    validates :title, length: { maximum: 15 }
    with_options length: { maximum: 20 } do
      validates :first_place
      validates :second_place
      validates :third_place
    end
  end
end
