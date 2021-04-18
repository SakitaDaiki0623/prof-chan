# == Schema Information
#
# Table name: question_items
#
#  id                 :bigint           not null, primary key
#  answer             :string(255)      not null
#  question_block_id  :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/ranking_item.rb
class RankingItem < ApplicationRecord
  # association =============
  belongs_to :ranking_block

  # validation =============
  validates :answer, presence: true, length: { maximum: 30 }
end
