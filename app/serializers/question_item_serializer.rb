# app/serializers/question_item_serializer.rb
class QuestionItemSerializer < ActiveModel::Serializer
  attributes :id, :content, :answer, :question_block
  belongs_to :question_block, serializer: QuestionBlockSerializer

  def question_block
    object.question_block
  end
end
