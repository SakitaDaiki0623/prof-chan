class ProfileSerializer < ApplicationSerializer
  attributes :id, :birthday, :day_of_joinning, :height, :gender, :blood_type, :prefecture_id, :public_uid
  belongs_to :user

  def gender
    object.gender_i18n
  end

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
