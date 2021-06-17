class TeamSerializer < ApplicationSerializer
  attributes :name, :image, :workspace_id
  lazy_has_many :users
end
