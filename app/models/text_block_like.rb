class TextBlockLike < ApplicationRecord
  belongs_to :user
  belongs_to :text_block

  scope :filter_by_text_block, ->(text_block_id) { where(text_block_id: text_block_id) if text_block_id }
end
