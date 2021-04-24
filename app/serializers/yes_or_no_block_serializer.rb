# app/serializers/yes_or_no_block_serializer.rb
class YesOrNoBlockSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many   :yes_or_no_items,  serializer: YesOrNoItemSerializer
  belongs_to :profile_block,    serializer: ProfileBlockSerializer
end
