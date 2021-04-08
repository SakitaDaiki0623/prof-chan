class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :birthday, :day_of_joinning, :height, :gender, :blood_type, :prefecture_id
  belongs_to :user
end
