class ProfilePolicy < ApplicationPolicy
  def index?
    user.profile.present?
  end

  def new?
    user.profile.nil?
  end

  def show?
    user.team.workspace_id == record.user.team.workspace_id
  end

  def update?
    user.id == record.user_id
  end
end
