class User < ApplicationRecord
  after_create do
    create_profile_block if profile_block.blank?
    create_share_right if share_right.blank?
  end

  before_validation do
    set_default_team if team.nil?
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable

  mount_uploader :image, ImageUploader

  enum role: { admin: 0, general: 1 }

  has_one :profile,        dependent: :destroy
  has_one :profile_block,  dependent: :destroy
  has_one :share_right, dependent: :destroy
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

  validates :name,                      presence: true
  validates :image,                     presence: true
  validates :provider,                  presence: true
  validates :email, uniqueness: { scope: %i[team_id provider uid], case_sensitive: true }
  validates :password, presence: true, length: { minimum: 6 }
  validates :agreement, acceptance: { allow_nil: false, on: :create, unless: proc { |u| u.email == 'guest@example.com' || u.provider == 'slack' } }

  def create_guest_profile
    profile_params = { birthday: Date.new(2000, 5, 4), day_of_joinning: Date.new(2021, 6, 4), height: 5, gender: 'female', blood_type: 'O', prefecture_id: 13 }
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

  def set_default_team
    default_team = Team.find_or_create_by(workspace_id: 'A123B123C123') do |team|
      team.name = 'normal login',
                  team.workspace_id     = 'A123B123C123',
                  team.share_channel_id = 'A123B123C123',
                  team.share_channel_name = 'A123B123C123',
                  team.domain = 'A123B123C123',
                  team.image = 'https://i.gyazo.com/f0c0826c1358634f1821320e5530f8ec.png'
    end
    self.team = default_team
  end

  def self.from_omniauth(auth, bot_token)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.info.authed_user.id)
    hash_token = bot_token.to_hash
    user_info = SlackApiMethod.users_identity(bot_token)
    channel = user.check_channel(user_info, auth, hash_token)
    user.password = Devise.friendly_token[0, 20]
    user.name = user_info.dig('user', 'name')
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

  def check_team_existence(team_info, channel)
    workspace_id = team_info.dig('id')

    if Team.exists?(workspace_id: workspace_id)
      team = Team.find_by(workspace_id: workspace_id)
      team.update!(image: team_info.dig('image_230'), share_channel_name: channel.dig('name'), share_channel_id: channel.dig('id'))
    else
      name = team_info.dig('name')
      image = team_info.dig('image_230')
      domain = team_info.dig('domain')
      share_channel_id = channel.dig('id')
      share_channel_name = channel.dig('name')
      team = Team.create!(name: name,
                          workspace_id: workspace_id,
                          image: image,
                          share_channel_id: share_channel_id,
                          share_channel_name: share_channel_name,
                          domain: domain,
                          share_right: 'active')
    end
    self.team = team
  end

  def check_channel(info, _auth, hash_token)
    access_token = OmniAuth::Slack.build_access_token(ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], hash_token)
    team = Team.find_by(workspace_id: info.dig('team', 'id'))
    channel_id = team.share_channel_id if team.present?
    user = User.find_by(uid: info.dig('user', 'id'))
    channels = SlackApiMethod.conversations_list(access_token).dig('channels')
    channel = channels.select { |c| c.dig('id') == channel_id }[0]
    return channel if team.present? && user.present? && channel.present?

    if channel.nil?
      general_channel = get_general_channel(channels)
      created_channel = create_channel_flow(info, channels, access_token, general_channel)
      created_channel
    elsif user.nil? && channel.present?
      invite_user_flow(info, channel, access_token)
      channel
    end
  end

  private

  def get_general_channel(channels)
    channel = channels.select { |c| c.dig('is_general') }[0]
    channel
  end

  def create_channel_flow(info, channels, access_token, general_channel)
    created_channel = create_channel_in_team(channels, access_token)
    invite_result = try_invite_user(info, created_channel, access_token)
    if invite_result.dig('ok')
      post_app_installed_message_to_general(access_token, general_channel)
      post_messages(info, created_channel, access_token)
    elsif invite_result.dig('ok') == false && invite_result.dig('error') == 'not_in_channel'
      invite_bot_result = try_invite_bot(created_channel, access_token)
      if invite_bot_result.dig('ok')
        try_invite_user(info, created_channel, access_token)
        post_messages(info, created_channel, access_token)
      end
    end
    created_channel
  end

  def invite_user_flow(info, channel, access_token)
    invite_result = try_invite_user(info, channel, access_token)
    if invite_result.dig('ok')
      post_messages(info, channel, access_token)
    elsif invite_result.dig('ok') == false && invite_result.dig('error') == 'not_in_channel'
      invite_bot_result = try_invite_bot(channel, access_token)
      if invite_bot_result.dig('ok')
        try_invite_user(info, channel, access_token)
        post_messages(info, channel, access_token)
      end
    end
    channel
  end

  def post_messages(info, channel, access_token)
    post_welcome_message_to_channel(info, channel, access_token)
    post_direct_message_to_user(info, channel, access_token)
  end

  def create_channel_in_team(channels, access_token)
    channel_name = 'プロフちゃんスペース'
    channel = channels.select { |c| c.dig('name') == channel_name }[0]
    if channel.nil?
      encoded_channel_name = URI.encode_www_form_component(channel_name)
      create_result = SlackApiMethod.conversations_create(access_token, encoded_channel_name)
      create_result.dig('channel')
    else
      channel_id = channel.dig('id')
      info_result = SlackApiMethod.conversations_info(access_token, channel_id)
      info_result.dig('channel')
    end
  end

  def try_invite_user(info, channel, access_token)
    channel_id = channel.dig('id')
    user_id = info.dig('user', 'id')
    SlackApiMethod.conversations_invite(access_token, channel_id, user_id)
  end

  def try_invite_bot(channel, access_token)
    channel_id = channel.dig('id')
    SlackApiMethod.conversations_join(access_token, channel_id)
  end

  def post_welcome_message_to_channel(info, channel, access_token)
    channel_id = channel.dig('id')
    user_id = info.dig('user', 'id')
    encoded_msg = BlockKitMessage.welcome_msg(info)
    text = "<@#{user_id}>さんがプロフちゃんを始めました！:hamster:"
    encoded_text = URI.encode_www_form_component(text)
    SlackApiMethod.chat_post_message(access_token, channel_id, encoded_msg, encoded_text)
  end

  def post_direct_message_to_user(info, channel, access_token)
    user_id = info.dig('user', 'id')
    encoded_msg = BlockKitMessage.direct_msg_when_installed(info, channel)
    text = 'プロフちゃんの世界へようこそ:hamster:'
    encoded_text = URI.encode_www_form_component(text)
    SlackApiMethod.chat_post_message(access_token, user_id, encoded_msg, encoded_text)
  end

  def post_app_installed_message_to_general(access_token, general_channel)
    try_invite_bot(general_channel, access_token)
    channel_id = general_channel.dig('id')
    text = 'プロフちゃんがインストールされました:hamster:'
    encoded_text = URI.encode_www_form_component(text)
    encoded_msg = BlockKitMessage.app_installed_msg
    SlackApiMethod.chat_post_message(access_token, channel_id, encoded_msg, encoded_text)
  end
end
