# == Schema Information
#
# Table name: question_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  first_place        :string(255)      not null
#  second_place       :string(255)      not null
#  third_place        :string(255)      not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/ranking_block.rb
class RankingBlock < ApplicationRecord
  # association =============
  belongs_to :profile_block

  # validation =============
  validates :title,         presence: true, length: { maximum: 50 }
  validates :first_place,   presence: true, length: { maximum: 50 }
  validates :second_place,  presence: true, length: { maximum: 50 }
  validates :third_place,   presence: true, length: { maximum: 50 }

  # scope ============= # Ex:- scope :active, -> {where(:active => true)}
  scope :by_team, -> (current_user) { includes(profile_block: { user: :team }).where(teams: { workspace_id: User.find(current_user.id).team.workspace_id })}
end
