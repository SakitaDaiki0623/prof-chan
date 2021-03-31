# == Schema Information
#
# Table name: profiles
#
#  id                 :bigint           not null, primary key
#  user_id            :bigint           not null, foreign_key
#  introduction       :text
#  height             :integer          not null
#  gender             :integer          not null
#  birthday           :datetime         not null
#  day_of_joinning    :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)

# app/models/profile.rb
class Profile < ApplicationRecord

  # association
  belongs_to :user

  # enum =============
  enum gender: { male: 0, female: 1 }
  enum blood_type: { A: 0, B: 1, AB: 2, O: 3 }

  # validation =============
  validates :height, presence: true, numericality: true
  validates :gender, presence: true
  validates :prefecture_id, presence: true
  validates :blood_type, presence: true
  validates :introduction, length: { maximum: 2000 }
  validates :birthday, presence: true
  validate  :birthday_cannot_be_in_the_future
  validates :day_of_joinning, presence: true

  # custom validation =============
  def birthday_cannot_be_in_the_future
    errors.add(:birthday, 'に未来の日付は使えません') if birthday.present? && birthday > Time.zone.today
  end

  # active hash =============
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
