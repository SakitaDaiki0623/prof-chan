class ApplicationSerializer < ActiveModel::Serializer

  def owing_user
    object.profile_block.user
  end
end