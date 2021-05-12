class ProfileBlockSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :user, serializer: UserSerializer
  has_many :text_blocks
end
