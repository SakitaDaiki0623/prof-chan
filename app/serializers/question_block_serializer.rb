# app/serializers/question_block_serializer.rb
class QuestionBlockSerializer < ActiveModel::Serializer
  attributes :id, :title, :user
  has_many   :question_items,  serializer: QuestionItemSerializer
  belongs_to :profile_block,   serializer: ProfileBlockSerializer
  has_many :question_block_likes
  has_many :users, through: :question_block_likes

  def user
    object.profile_block.user
  end
end
