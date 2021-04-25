class QuestionBlockLike < ApplicationRecord
  belongs_to :user
  belongs_to :question_block

  scope :filter_by_question_block, ->(question_block_id) { where(question_block_id: question_block_id) if question_block_id }
end
