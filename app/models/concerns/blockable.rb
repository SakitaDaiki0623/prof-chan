require 'active_support'

module Blockable
  extend ActiveSupport::Concern

  included do
    scope :by_team, ->(user) { includes(profile_block: { user: :team }).where(teams: { workspace_id: User.find(user.id).team.workspace_id }) }
  end
end