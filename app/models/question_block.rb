class QuestionBlock < ApplicationRecord
  belongs_to :profile_block
  has_many :question_items, dependent: :destroy
  has_many :question_block_likes, dependent: :destroy
  has_many :users, through: :question_block_likes
end
