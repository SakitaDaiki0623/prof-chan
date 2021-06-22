class YesOrNoBlock < ApplicationRecord
  belongs_to :profile_block
  has_many :yes_or_no_items, dependent: :destroy
  has_many :yes_or_no_block_likes, dependent: :destroy
  has_many :users, through: :yes_or_no_block_likes
end
