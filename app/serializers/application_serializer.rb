class ApplicationSerializer < ActiveModel::Serializer
  include AmsLazyRelationships::Core

  def owing_user
    object.profile_block.user
  end
end
