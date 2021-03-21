# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_one :profile, dependent: :destroy

  def self.from_omniauth(auth, user_token)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user_info = user_token.get("/api/users.identity").parsed.dig("user")
    user.name = user_info["name"]
    user.image = user_info["image_72"]
    user.email = user_info["email"]
    user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを作成
    user.provider = auth.provider
    user.slack_credential_token = auth.credentials.token
    user.save
    user
  end
end
