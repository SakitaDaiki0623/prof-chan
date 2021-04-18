# == Schema Information
#
# Table name: question_items
#
#  id                 :bigint           not null, primary key
#  content            :string(255)      not null
#  answer             :string(255)
#  question_block_id  :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/question_item.rb
class QuestionItem < ApplicationRecord
  # association =============
  belongs_to :question_block

  # カスタムバリデーション
  MAX_QUESTION_ITEMS_COUNT = 3
  validate :question_items_count_must_be_within_limit

  def question_items_count_must_be_within_limit
    errors.add(:base, "question_items count limit: #{MAX_QUESTION_ITEMS_COUNT}") if profile_block.question_items.count >= MAX_QUESTION_ITEMS_COUNT
  end
end
