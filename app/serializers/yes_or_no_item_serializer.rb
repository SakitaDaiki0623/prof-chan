# app/serializers/yes_or_no_item_serializer.rb
class YesOrNoItemSerializer < ActiveModel::Serializer
  attributes :id, :content, :answer, :yes_or_no_block
  belongs_to :yes_or_no_block, serializer: YesOrNoBlockSerializer

  delegate :yes_or_no_block, to: :object
end
