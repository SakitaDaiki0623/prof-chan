class YesOrNoBlockItemRegister
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :yes_or_no_title,         :string
  attribute :yes_or_no_item_content1, :string
  attribute :yes_or_no_item_answer1,  :boolean
  attribute :yes_or_no_item_content2, :string
  attribute :yes_or_no_item_answer2,  :boolean
  attribute :yes_or_no_item_content3, :string
  attribute :yes_or_no_item_answer3,  :boolean
  attribute :profile_block_id, :integer

  validates :yes_or_no_title,         presence: true,        length: { maximum: 20 }
  validates :yes_or_no_item_content1, presence: true,        length: { maximum: 20 }
  validates :yes_or_no_item_content2,                        length: { maximum: 20 }
  validates :yes_or_no_item_content3,                        length: { maximum: 20 }
  validates :profile_block_id, presence: true

  def save_block_and_items
    return false if invalid?

    ActiveRecord::Base.transaction do
      yes_or_no_block = YesOrNoBlock.create!(title: yes_or_no_title, profile_block_id: profile_block_id)

      yes_or_no_block.yes_or_no_items.create!(content: yes_or_no_item_content1, answer: yes_or_no_item_answer1)
      yes_or_no_block.yes_or_no_items.create!(content: yes_or_no_item_content2, answer: yes_or_no_item_answer2) if yes_or_no_item_content2.present?
      yes_or_no_block.yes_or_no_items.create!(content: yes_or_no_item_content3, answer: yes_or_no_item_answer3) if yes_or_no_item_content3.present?
    end
    true
  end
end
