class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image
  has_one :profile
  has_one :profile_block
end
