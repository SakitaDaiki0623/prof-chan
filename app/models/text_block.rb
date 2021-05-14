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
  has_many :text_block_likes, dependent: :destroy

  # validation =============
  validates :title, presence: true,      length: { maximum: 50 }
  validates :text,  presence: true,      length: { maximum: 200 }

    # scope ============= # Ex:- scope :active, -> {where(:active => true)}
    scope :by_team, ->(user) { includes(profile_block: { user: :team }).where(teams: { workspace_id: User.find(user.id).team.workspace_id }) }
end
