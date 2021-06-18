class ApplicationSerializer < ActiveModel::Serializer
  include AmsLazyRelationships::Core

  def owing_user_name
    object.profile_block.user.name
  end

  def owing_user_image
    object.profile_block.user.image
  end

  def owing_user_id
    object.profile_block.user.id
  end
end
