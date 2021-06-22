class QuestionItem < ApplicationRecord
  belongs_to :question_block

  scope :by_team_block, ->(user) { includes(question_block: { profile_block: { user: :team } }).where(teams: { workspace_id: User.find(user.id).team.workspace_id }) }
end
