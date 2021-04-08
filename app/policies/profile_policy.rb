# app/policies/profile_policy.rb
class ProfilePolicy < ApplicationPolicy
  def index?
    user.profile.present?
  end

  def new?
    user.profile.nil?
  end
end
