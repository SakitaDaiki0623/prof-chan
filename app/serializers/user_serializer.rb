class UserSerializer < ApplicationSerializer
  attributes :id, :name, :image, :provider, :question_share_right, :ranking_share_right, :yes_or_no_share_right, :text_share_right
  lazy_has_one :profile
  lazy_has_one :profile_block
  belongs_to :team
end
