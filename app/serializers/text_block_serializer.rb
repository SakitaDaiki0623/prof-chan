# app/serializers/text_block_serializer.rb
class TextBlockSerializer < ActiveModel::Serializer
  attributes :id, :title, :text
  belongs_to :profile_block, serializer: ProfileBlockSerializer
  has_many :text_block_likes, dependent: :destroy
  has_many :users, through: :text_block_likes
end
