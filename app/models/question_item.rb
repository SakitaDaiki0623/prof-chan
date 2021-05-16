# == Schema Information
#
# Table name: question_items
#
#  id                 :bigint           not null, primary key
#  content            :string(255)      not null
#  answer             :string(255)
#  question_block_id  :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/question_item.rb
class QuestionItem < ApplicationRecord
  # association =============
  belongs_to :question_block

  scope :by_team_block, ->(user) { includes(question_block: { profile_block: { user: :team } }).where(teams: { workspace_id: User.find(user.id).team.workspace_id }) }
end
