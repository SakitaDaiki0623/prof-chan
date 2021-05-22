class FavoriteBlockSerializer < ApplicationSerializer
  attributes :id, :text, :category_id, :category_name, :owing_user
  belongs_to :profile_block

  def category_name
    object.category.name
  end
end
