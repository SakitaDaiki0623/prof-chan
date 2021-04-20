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

  delegate :persisted?, to: :question_block

  # 編集で入力された値（attributes）があれば、既に存在するdefault_attributesにマージして更新している
  def initialize(attributes = {}, question_block: QuestionBlock.new)
    @question_block = question_block
    new_attributes ||= default_attributes.merge(attributes)
    super(new_attributes)
  end

  def update
    return false if invalid?

    ActiveRecord::Base.transaction do
      question_title = attributes["question_title"]
      question_item_content1 = attributes["question_item_content1"]
      question_item_answer1  = attributes["question_item_answer1"]
      question_item_content2 = attributes["question_item_content2"]
      question_item_answer2  = attributes["question_item_answer2"]
      question_item_content3 = attributes["question_item_content3"]
      question_item_answer3  = attributes["question_item_answer3"]

      @question_block.update!(title: question_title)
      @question_block.question_items[0].update!(content: question_item_content1, answer: question_item_answer1)
      @question_block.question_items[1].update!(content: question_item_content2, answer: question_item_answer2) if question_item_content2.present?
      @question_block.question_items[2].update!(content: question_item_content3, answer: question_item_answer3) if question_item_content2.present?
    end
    true
  end

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

  private

  # 既存の値を取得
  def default_attributes
    if @question_block.valid?
      {
        question_title:         @question_block.title,
        question_item_content1: @question_block.question_items[0].content,
      }
    else
      {}
    end
  end
end
