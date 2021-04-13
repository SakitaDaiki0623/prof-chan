# == Schema Information
#
# Table name: question_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/question_block.rb
class QuestionBlock < ApplicationRecord
  # association =============
  belongs_to :profile_block
  has_many :question_items, dependent: :destroy

  # validation =============
  validates :title, presence: true,      length: { maximum: 30 }
end
