# app/models/profile_block.rb
class ProfileBlock < ApplicationRecord
  has_many :text_blocks,       dependent: :destroy
  has_many :question_blocks,   dependent: :destroy
  has_many :ranking_blocks,    dependent: :destroy
  has_many :yes_or_no_blocks,  dependent: :destroy
  has_many :favorite_blocks, dependent: :destroy
  has_one  :address_block, dependent: :destroy
  belongs_to :user
  has_one :my_favorite_block, dependent: :destroy

  after_create  :create_address_block
  after_create  :create_my_favorite_block
end
