class QuestionBlockLike < ApplicationRecord
  belongs_to :user
  belongs_to :question_block
end
