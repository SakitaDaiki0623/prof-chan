class YesOrNoBlockLikeSerializer < ApplicationSerializer
  attributes :id
  belongs_to :user
  belongs_to :yes_or_no_block
end
