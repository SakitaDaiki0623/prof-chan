# app/serializers/yes_or_no_block_serializer.rb
class YesOrNoBlockSerializer < ApplicationSerializer
  attributes :id, :title, :owing_user
  lazy_has_many   :yes_or_no_items, serializer: YesOrNoItemSerializer
  belongs_to :profile_block, serializer: ProfileBlockSerializer
  lazy_has_many :yes_or_no_block_likes
  lazy_has_many :users, through: :yes_or_no_block_likes
end
