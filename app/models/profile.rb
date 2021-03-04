# app/models/profile.rb
class Profile < ApplicationRecord
  belongs_to :user

  enum gender: { male: 0, female: 1 }

  validates :height, presence: true, numericality: true
  validates :gender, presence: true
  validates :introduction, length: { maximum: 4000 }
  validates :birthday, presence: true
  validates :day_of_joinning, presence: true
end
