class QuestionItemSerializer < ApplicationSerializer
  attributes :id, :content, :answer, :question_block
  belongs_to :question_block, serializer: QuestionBlockSerializer

  delegate :question_block, to: :object
end
