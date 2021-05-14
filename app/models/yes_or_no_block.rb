# == Schema Information
#
# Table name: yes_or_no_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/yes_or_no_block.rb
class YesOrNoBlock < ApplicationRecord
  # association =============
  belongs_to :profile_block
  has_many :yes_or_no_items, dependent: :destroy
  has_many :yes_or_no_block_likes, dependent: :destroy
end
