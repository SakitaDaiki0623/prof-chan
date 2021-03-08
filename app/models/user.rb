# app/models/user.rb
class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one :profile, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
end
