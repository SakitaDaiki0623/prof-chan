# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  name               :string(255)      default(""), not null
#  email              :string(255)      not null, unique: true
#  provider           :string(255)      default(""), not null
#  uid                :string(255)      not null, unique: true
#  image              :string(255)
#  team_id            :string(255)      not null
#  encrypted_password :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slack_credential_token  :string(255)     not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :string(255)
#  remember_created_at     :string(255)
#
# Indexes
#
#  index_users_on_email                    (email)
#  index_users_on_reset_password_token     (reset_password_token)

# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_one :profile, dependent: :destroy

  #  Validation
  validates :name,                      presence: true, length: { in: 1..15 }
  validates :email,                     presence: true, uniqueness: { case_sensitive: true }
  validates :provider,                  presence: true
  validates :uid,                       presence: true, uniqueness: { case_sensitive: true }
  validates :team_id,                   presence: true
  validates :encrypted_password,        presence: true
  validates :slack_credential_token,    presence: true
  # TODO: imageカラムにバリデーションを追加


  # Deviseによる外部認証時にAPI情報をUserのカラムに格納
  def self.from_omniauth(auth, user_token)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user_info = user_token.get("/api/users.identity").parsed.dig("user")
    user.name = user_info["name"]
    user.image = user_info["image_72"]
    user.email = user_info["email"]
    user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを作成
    user.provider = auth.provider
    user.slack_credential_token = auth.credentials.token
    user.team_id = auth.extra.raw_info.team.id
    user.save
    user
  end
end
