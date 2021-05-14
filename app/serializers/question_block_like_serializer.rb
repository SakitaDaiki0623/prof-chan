class QuestionBlockLikeSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user
  belongs_to :question_block
end
