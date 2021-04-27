# == Schema Information
#
# Table name: profile_blocks
#
#  id                 :bigint           not null, primary key
#  user_id            :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/profile_block.rb
class ProfileBlock < ApplicationRecord
  # association ==========
  has_many :text_blocks,       dependent: :destroy
  has_many :question_blocks,   dependent: :destroy
  has_many :ranking_blocks,    dependent: :destroy
  has_many :yes_or_no_blocks,  dependent: :destroy
  has_one  :my_favorite_block, dependent: :destroy
  has_one  :address_block,     dependent: :destroy
  belongs_to :user

  # after_create
  after_create :create_my_favorite_block
  after_create :create_address_block
end
