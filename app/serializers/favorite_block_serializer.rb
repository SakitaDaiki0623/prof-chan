class FavoriteBlockSerializer < ApplicationSerializer
  attributes :id, :text, :category_id, :category_name, :owing_user
  belongs_to :profile_block
  lazy_has_many :favorite_block_likes
  lazy_has_many :users, through: :favorite_block_likes

  def category_name
    object.category.name
  end
end
