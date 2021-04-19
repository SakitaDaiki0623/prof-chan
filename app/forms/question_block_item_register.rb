# [参考] https://qiita.com/kumackey/items/b469143f1a0c4902cf4e
# app/forms/question_block_item_register.rb
class QuestionBlockItemRegister
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :question_title,         :string
  attribute :question_item_content1, :string
  attribute :question_item_answer1,  :string
  attribute :question_item_content2, :string
  attribute :question_item_answer2,  :string
  attribute :question_item_content3, :string
  attribute :question_item_answer3,  :string
  attribute :profile_block_id,       :integer

  # validation =============
  validates :question_title,         presence: true,        length: { maximum: 30 }
  validates :question_item_content1, presence: true,        length: { maximum: 30 }
  validates :question_item_answer1,                         length: { maximum: 30 }
  validates :question_item_content2,                        length: { maximum: 30 }
  validates :question_item_answer2,                         length: { maximum: 30 }
  validates :question_item_content3,                        length: { maximum: 30 }
  validates :question_item_answer3,                         length: { maximum: 30 }
  validates :profile_block_id,        presence: true

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      question_block = QuestionBlock.create!(title: question_title, profile_block_id: profile_block_id)

      question_block.question_items.create!(content: question_item_content1, answer: question_item_answer1)
      question_block.question_items.create!(content: question_item_content2, answer: question_item_answer2) if question_item_content2.present?
      question_block.question_items.create!(content: question_item_content3, answer: question_item_answer3) if question_item_content3.present?
    end
    true
  end
end
