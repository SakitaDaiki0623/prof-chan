class ProfileBlockSerializer < ApplicationSerializer
  attributes :id

  belongs_to :user, serializer: UserSerializer
  has_many :question_blocks
  has_many :ranking_blocks
  has_many :yes_or_no_blocks
  has_many :text_blocks
end
