class FavoriteBlockSerializer < ApplicationSerializer
  attributes :id, :name, :category_id

  def category_name
    object.category.name
  end
end
