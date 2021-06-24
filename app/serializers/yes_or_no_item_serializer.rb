class YesOrNoItemSerializer < ApplicationSerializer
  attributes :id, :content, :answer, :yes_or_no_block
  belongs_to :yes_or_no_block, serializer: YesOrNoBlockSerializer

  delegate :yes_or_no_block, to: :object
end
