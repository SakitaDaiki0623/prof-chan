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

  # validation =============
  validates :content, presence: true,      length: { maximum: 30 }
  validates :answer,                       length: { maximum: 30 }
end
