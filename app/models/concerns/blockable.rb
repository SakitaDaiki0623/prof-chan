require 'active_support'

module Blockable
  extend ActiveSupport::Concern

  included do
    scope :by_team, ->(user) { includes(profile_block: { user: :team }).where(teams: { workspace_id: User.find(user.id).team.workspace_id }) }
    scope :popular_blocks, ->() { includes(:users).sort {|a,b| b.users.size <=> a.users.size} }
  end
end