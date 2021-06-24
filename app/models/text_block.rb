class TextBlock < ApplicationRecord
  belongs_to :profile_block
  has_many :text_block_likes, dependent: :destroy
  has_many :users, through: :text_block_likes

  validates :title, presence: true,      length: { maximum: 15 }
  validates :text,  presence: true,      length: { maximum: 400 }
end
