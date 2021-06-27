class UserSerializer < ApplicationSerializer
  attributes :id, :name, :image, :provider
  lazy_has_one :profile
  lazy_has_one :profile_block
  lazy_has_one :share_right
  belongs_to :team
end
