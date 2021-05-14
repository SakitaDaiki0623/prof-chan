# == Schema Information
#
# Table name: question_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  first_place        :string(255)      not null
#  second_place       :string(255)      not null
#  third_place        :string(255)      not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/ranking_block.rb
class RankingBlock < ApplicationRecord
  # association =============
  belongs_to :profile_block
  has_many :ranking_block_likes, dependent: :destroy
  has_many :users, through: :ranking_block_likes

  # validation =============
  with_options presence: true do
    with_options length: { maximum: 50 } do
      validates :title
      validates :first_place
      validates :second_place
      validates :third_place
    end
  end
end
