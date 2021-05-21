class FavoriteBlockSerializer < ApplicationSerializer
  attributes :id, :name, :category_id
  belongs_to :profile_block

  def category_name
    object.category.name
  end
end
