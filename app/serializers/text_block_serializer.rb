# app/serializers/text_block_serializer.rb
class TextBlockSerializer < ActiveModel::Serializer
  attributes :id, :title, :text
  belongs_to :profile_block
end
