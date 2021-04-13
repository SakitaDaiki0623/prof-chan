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
  has_many :text_blocks, dependent: :destroy
  belongs_to :user
end
