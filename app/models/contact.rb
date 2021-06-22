class Contact < ApplicationRecord
  # validation
  validates :name, presence: true
  validates :category, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email,                     presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :message,                   presence: true
end
