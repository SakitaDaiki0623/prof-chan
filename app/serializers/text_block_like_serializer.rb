class TextBlockLikeSerializer < ApplicationSerializer
  attributes :id
  belongs_to :user
  belongs_to :text_block
end
