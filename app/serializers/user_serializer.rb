class UserSerializer < ApplicationSerializer
  attributes :id, :name, :image, :provider
  lazy_has_one :profile
  lazy_has_one :profile_block
end
