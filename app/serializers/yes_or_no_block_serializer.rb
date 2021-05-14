# app/serializers/yes_or_no_block_serializer.rb
class YesOrNoBlockSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many   :yes_or_no_items,  serializer: YesOrNoItemSerializer
  belongs_to :profile_block,    serializer: ProfileBlockSerializer
  has_many :yes_or_no_block_likes
  has_many :users, through: :yes_or_no_block_likes
end
