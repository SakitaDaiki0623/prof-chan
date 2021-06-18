# app/serializers/text_block_serializer.rb
class TextBlockSerializer < ApplicationSerializer
  attributes :id, :title, :text, :owing_user_id, :owing_user_image, :owing_user_name
  belongs_to :profile_block, serializer: ProfileBlockSerializer
  lazy_has_many :text_block_likes, dependent: :destroy
  lazy_has_many :users, through: :text_block_likes
end
