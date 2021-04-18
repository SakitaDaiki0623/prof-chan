# [参考] https://qiita.com/Tiima/items/b14c73df98d0465cbb52
# app/forms/question_block_item.rb
class QuestionBlockItem
  include ActiveModel::Model
  attr_accessor :title, :content, :answer

  # validation =============
  validates :title, presence: true,        length: { maximum: 30 }
  validates :content, presence: true,      length: { maximum: 30 }
  validates :answer,                       length: { maximum: 30 }

  def create_question_block
    profile_block = ProfileBlock.find_by(user_id: current_user.id)

    question_block = QuestionBlock.create(title: title, profile_block_id: profile_block.id)
    QuestionItem.create(content: content, answer: answer, question_block_id: question_block.id)
  end
end
