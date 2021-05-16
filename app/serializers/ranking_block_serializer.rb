# app/serializers/ranking_block_serializer.rb
class RankingBlockSerializer < ActiveModel::Serializer
  attributes :id, :title, :first_place, :second_place, :third_place, :user
  belongs_to :profile_block, serializer: ProfileBlockSerializer
  has_many :ranking_block_likes
  has_many :users, through: :ranking_block_likes

  def user
    object.profile_block.user
  end
end
