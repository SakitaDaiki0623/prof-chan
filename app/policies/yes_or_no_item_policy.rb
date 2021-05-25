class YesOrNoItemPolicy < ApplicationPolicy
  def update?
    user.profile_block.id == record.yes_or_no_block.profile_block.id
  end
end
