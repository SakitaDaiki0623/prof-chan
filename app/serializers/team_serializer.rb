class TeamSerializer < ApplicationSerializer
  attributes :id, :name, :image
  has_many :users
end
