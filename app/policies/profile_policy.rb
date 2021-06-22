class ProfilePolicy < ApplicationPolicy
  def index?
    user.profile.present?
  end

  def new?
    user.profile.nil?
  end

  def update?
    user.id == record.user_id
  end
end
