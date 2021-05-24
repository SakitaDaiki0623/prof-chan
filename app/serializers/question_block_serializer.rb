# app/serializers/question_block_serializer.rb
class QuestionBlockSerializer < ApplicationSerializer
  attributes :id, :title, :owing_user
  lazy_has_many   :question_items,  serializer: QuestionItemSerializer
  belongs_to :profile_block,   serializer: ProfileBlockSerializer
  lazy_has_many :question_block_likes
  lazy_has_many :users, through: :question_block_likes
end
