class QuestionItemPolicy < ApplicationPolicy
  def update?
    user.profile_block.id == record.question_block.profile_block_id
  end
end
