class UserSerializer < ApplicationSerializer
  attributes :id, :name, :image, :provider, :workspace_id
  lazy_has_one :profile
  lazy_has_one :profile_block

  def workspace_id
    object.team.workspace_id
  end
end
