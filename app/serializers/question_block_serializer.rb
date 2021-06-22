class QuestionBlockSerializer < ApplicationSerializer
  attributes :id, :title, :owing_user_id, :owing_user_image, :owing_user_name
  lazy_has_many   :question_items, serializer: QuestionItemSerializer
  belongs_to :profile_block, serializer: ProfileBlockSerializer
  lazy_has_many :question_block_likes
  lazy_has_many :users, through: :question_block_likes
end
