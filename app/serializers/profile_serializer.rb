# app/serializers/profile_serializer.rb
class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :birthday, :day_of_joinning, :height, :gender, :blood_type, :prefecture_id
  belongs_to :user

  def gender
    object.gender_i18n
  end

  # TODO: 後ほどprefectureに戻す
  def prefecture_id
    object.prefecture.name
  end

  def birthday
    object.birthday.strftime('%F')
  end

  def day_of_joinning
    object.day_of_joinning.strftime('%F')
  end
end
