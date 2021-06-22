class YesOrNoItem < ApplicationRecord
  belongs_to :yes_or_no_block

  scope :by_team_block, ->(user) { includes(yes_or_no_block: { profile_block: { user: :team } }).where(teams: { workspace_id: User.find(user.id).team.workspace_id }) }
end
