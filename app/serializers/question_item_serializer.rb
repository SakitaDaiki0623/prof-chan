# app/serializers/question_item_serializer.rb
class QuestionItemSerializer < ActiveModel::Serializer
  attributes :id, :content, :answer
  belongs_to :question_block, serializer: QuestionBlockSerializer
end
