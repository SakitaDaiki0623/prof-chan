# == Schema Information
#
# Table name: text_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  text               :text             not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/text_block.rb
class TextBlock < ApplicationRecord
  # association ==========
  belongs_to :profile_block

  # validation =============
  validates :title, presence: true,      length: { maximum: 30 }
  validates :text,  presence: true,      length: { maximum: 100 }
end
