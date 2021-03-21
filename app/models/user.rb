# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_one :profile, dependent: :destroy

  def self.from_omniauth(auth, access_token)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.name = auth.info.name
    user.provider = auth.provider
    user.slack_credential_token = auth.credentials.token
    user.save
    binding.pry
    user
  end
end
