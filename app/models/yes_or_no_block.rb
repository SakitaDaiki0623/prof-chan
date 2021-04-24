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

  # validation =============
  validates :title, presence: true, length: { maximum: 50 }

  # scope ============= # Ex:- scope :active, -> {where(:active => true)}
  scope :by_team, -> (current_user) { includes(profile_block: { user: :team }).where(teams: { workspace_id: User.find(current_user.id).team.workspace_id })}
end
