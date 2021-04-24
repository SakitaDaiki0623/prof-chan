# == Schema Information
#
# Table name: yes_or_no_items
#
#  id                 :bigint           not null, primary key
#  answer             :boolean          not null
#  question_block_id  :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/yes_or_no_item.rb
class YesOrNoItem < ApplicationRecord
  # association =============
  belongs_to :yes_or_no_block

  # validation
  validates :answer, inclusion: { in: [true, false] }

  # scope ============= # Ex:- scope :active, -> {where(:active => true)}
  scope :by_team, -> (current_user) { includes(yes_or_no_block: { profile_block: { user: :team } } ).where(teams: { workspace_id: User.find(current_user.id).team.workspace_id })}
end
