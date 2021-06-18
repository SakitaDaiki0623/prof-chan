# app/models/user.rb
class User < ApplicationRecord
  # after
  after_create do
    create_profile_block if profile_block.blank?
  end
  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable

  # carriwave
  mount_uploader :image, ImageUploader

  # enum
  enum role: { admin: 0, general: 1 }
  enum question_share_right: { question_not_shared_yet: 0, question_already_shared: 1 }
  enum ranking_share_right: { ranking_not_shared_yet: 0, ranking_already_shared: 1 }
  enum yes_or_no_share_right: { yes_or_no_not_shared_yet: 0, yes_or_no_already_shared: 1 }
  enum text_share_right: { text_not_shared_yet: 0, text_already_shared: 1 }

  # association
  has_one :profile,        dependent: :destroy
  has_one :profile_block,  dependent: :destroy
  has_one :authentication, dependent: :destroy

  belongs_to :team

  has_many :text_block_likes, dependent: :destroy
  has_many :text_blocks, through: :text_block_likes
  has_many :question_block_likes, dependent: :destroy
  has_many :question_blocks, through: :question_block_likes
  has_many :ranking_block_likes, dependent: :destroy
  has_many :ranking_blocks, through: :ranking_block_likes
  has_many :yes_or_no_block_likes, dependent: :destroy
  has_many :yes_or_no_blocks, through: :yes_or_no_block_likes
  has_many :favorite_block_likes, dependent: :destroy
  has_many :favorite_blocks, through: :favorite_block_likes

  # validation
  validates :name,                      presence: true
  validates :image,                     presence: true
  validates :email, uniqueness: { scope: %i[team_id provider] }
  validates :encrypted_password, presence: true
  # TODO: slackログインにも対応させる
  validates :agreement, acceptance: { allow_nil: false, on: :create, unless: proc { |u| u.email == 'guest@example.com' || u.provider == 'slack' } } # ゲストユーザは同意なしでログイン

  # methods ===========================

  def create_guest_profile
    profile_params = { birthday: Date.new(2021, 5, 4), day_of_joinning: Date.new(2021, 6, 4), height: 5, gender: 'female', blood_type: 'O', prefecture_id: 13 }
    profile = build_profile(profile_params)
    profile.save!
  end

  def self.guest
    find_or_create_by(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
      user.image = File.open(File.join(Rails.root, 'app/assets/images/prof_normal.png'))
    end
  end

  def set_default_team_value
    default_team = Team.find_or_create_by(workspace_id: 'A123B123C123') do |team|
      team.name = 'normal login',
                  team.workspace_id     = 'A123B123C123',
                  team.share_channel_id = 'A123B123C123',
                  team.image = 'https://i.gyazo.com/f0c0826c1358634f1821320e5530f8ec.png'
    end
    self.team = default_team
  end

  def self.from_omniauth(auth, user_info, hash_token, channel)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.info.authed_user.id)
    user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを作成
    user.name = user_info.dig('user', 'name')
    user.email = user_info.dig('user', 'email')
    user.remote_image_url = user_info.dig('user', 'image_192')
    user.check_authentication_existence(hash_token)
    user.check_team_existence(user_info.dig('team'), channel)
    user.save!
    user
  end

  def check_authentication_existence(hash_token)
    if authentication.present?
      authentication.update!(access_token: hash_token)
    else
      @authentication = build_authentication(access_token: hash_token)
      @authentication.save!
    end
  end

  # slackログイン時にユーザーが所属するチームがTeamテーブルにあるかどうかを確認
  def check_team_existence(team_info, channel)
    workspace_id = team_info.dig('id')

    self.team = if Team.exists?(workspace_id: workspace_id)
                  Team.find_by(workspace_id: workspace_id)
                else
                  # 無い場合は新規チームを作成し、ユーザーをそこに所属させる
                  name = team_info.dig('name')
                  image = team_info.dig('image_230')
                  share_channel_id = channel.dig('id')
                  Team.create!(name: name, workspace_id: workspace_id, image: image, share_channel_id: share_channel_id)
                end
  end
end
