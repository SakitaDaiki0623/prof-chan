class BlockPolicy < ApplicationPolicy
  def update?
    user.profile_block.id == record.profile_block.id
  end
end
