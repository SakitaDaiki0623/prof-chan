require 'active_support'

module Blockable
  extend ActiveSupport::Concern

  included do
    scope :by_team, ->(user) { includes(profile_block: { user: :team }).where(teams: { workspace_id: User.find(user.id).team.workspace_id }) }
    scope :random_other_user_block, ->(user) { includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample }
    scope :popular_blocks, -> { sort { |a, b| b.users.size <=> a.users.size }.take(3) }
    scope :filter_by_current_user, ->(current_user_id) { where(user_id: current_user_id) if current_user_id }
  end
end
