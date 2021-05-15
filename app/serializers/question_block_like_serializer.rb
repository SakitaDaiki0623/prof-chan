class QuestionBlockLikeSerializer < ApplicationSerializer
  attributes :id, :liked_user
  belongs_to :user
  belongs_to :question_block

  def liked_user
    object.question_block.profile_block.user
  end
end
