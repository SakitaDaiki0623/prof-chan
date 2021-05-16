class UserSerializer < ApplicationSerializer
  attributes :id, :name, :image
  has_one :profile
  has_one :profile_block
end
