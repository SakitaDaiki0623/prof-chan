class YesOrNoBlockLike < ApplicationRecord
  belongs_to :user
  belongs_to :yes_or_no_block

  scope :filter_by_yes_or_no_block, ->(yes_or_no_block_id) { where(yes_or_no_block_id: yes_or_no_block_id) if yes_or_no_block_id }
end
