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
    
    binding.pry
    
    user_info = user.get_user_info(bot_token)
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

  def check_channel(info, auth, hash_token)
    access_token = get_access_token(ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], hash_token)
    team = Team.find_by(workspace_id: info.dig('team', 'id'))
    channel_id = team.share_channel_id if team.present?
    user = User.find_by(uid: info.dig('user', 'id'))
    channels = get_channel_list(access_token).dig('channels')
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

  def get_access_token(client_id, client_secret, hash_token)
    OmniAuth::Slack.build_access_token(client_id, client_secret, hash_token)
  end

  def get_general_channel(channels)
    channel = channels.select { |c| c.dig('is_general')}[0]
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

  # API Methods
  def get_user_info(bot_token)
    user_token = bot_token.user_token
    user_token.get('/api/users.identity').parsed
  end

  def get_channel_list(access_token)
    access_token.get('/api/conversations.list?limit=1000&pretty=1').parsed
  end

  def create_channel_in_team(channels, access_token)
    channel_name = 'プロフちゃんスペース'
    channel = channels.select { |c| c.dig('name') == channel_name }[0]
    if channel.nil?
      encoded_name = URI.encode_www_form_component(channel_name)
      create_result = access_token.post("api/conversations.create?name=#{encoded_name}&pretty=1").parsed
      create_result.dig('channel')
    else
      channel_id = channel.dig('id')
      info_result = access_token.post("api/conversations.info?channel=#{channel_id}&pretty=1").parsed
      info_result.dig('channel')
    end
  end

  def try_invite_user(info, channel, access_token)
    channel_id = channel.dig('id')
    user_id = info.dig('user', 'id')
    access_token.post("api/conversations.invite?channel=#{channel_id}&users=#{user_id}&pretty=1").parsed
  end

  def try_invite_bot(channel, access_token)
    channel_id = channel.dig('id')
    access_token.post("api/conversations.join?channel=#{channel_id}&pretty=1").parsed
  end

  def post_welcome_message_to_channel(info, channel, access_token)
    channel_id = channel.dig('id')
    user_id = info.dig('user', 'id')
    encoded_mgs = get_block_kit_welcome_msg(info)
    text = "<@#{user_id}>さんがプロフちゃんを始めました！"
    encoded_text = URI.encode_www_form_component(text)
    access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_mgs}&text=#{encoded_text}&pretty=1").parsed
  end

  def post_direct_message_to_user(info, channel, access_token)
    user_id = info.dig('user', 'id')
    encoded_mgs = get_block_kit_direct_msg(info, channel)
    text = 'プロフちゃんの世界へようこそ'
    encoded_text = URI.encode_www_form_component(text)
    access_token.post("api/chat.postMessage?channel=#{user_id}&blocks=#{encoded_mgs}&text=#{encoded_text}&pretty=1").parsed
  end

  def post_app_installed_message_to_general(access_token, general_channel)
    try_invite_bot(general_channel, access_token)
    channel_id = general_channel.dig('id')
    text = "プロフちゃんがインストールされました:hamster:"
    encoded_text = URI.encode_www_form_component(text)
    encoded_mgs = get_block_kit_app_installed_message
    access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_mgs}&text=#{encoded_text}&pretty=1").parsed
  end

  # Block Kit message

  def get_block_kit_welcome_msg(info)
    user_id = info.dig('user', 'id')
    user_image = info.dig('user', 'image_192')
    message = "[ { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '@here \n <@#{user_id}>さんがプロフちゃんを始めました！:hamster:\n プロフを確認して気になる話題を探してみよう！:star: \n 共通の話題があると嬉しいな！' }, 'accessory': { 'type': 'image', 'image_url': '#{user_image}', 'alt_text': 'alt text for image' } }, { 'type': 'divider' } ]"
    ERB::Util.url_encode(message)
  end

  def get_block_kit_app_installed_message
    message = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': 'Slack App プロフちゃんがインストールされました:hamster:' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*本アプリについて*\n社内で特別な社員プロフィールを共有できるSlackと連携したアプリです:hamster:\n みんなが知らない趣味や特殊な項目を入力してみましょう！\n <https://www.prof-chan.com/|プロフちゃん公式サイト>' } }, { 'type': 'divider' } ]"
    ERB::Util.url_encode(message)
  end

  def get_block_kit_direct_msg(info, channel)
    team_domain = info.dig('team', 'domain')
    channel_id = channel.dig('id')
    channel_name = channel.dig('name')
    message = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': 'プロフちゃんの世界へようこそ:musical_note:\nこれからよろしくお願いします:hamster:\n' } }, { 'type': 'divider' }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*アプリ専用チャンネルについて* \n チームのプロフは<https://#{team_domain}.slack.com/archives/#{channel_id}/|##{channel_name}>で共有するよ！\n あなたが入力した内容を共有チャンネルでシェアしよう！ \n :warning:<https://#{team_domain}.slack.com/archives/#{channel_id}/|##{channel_name}>から退出するとあなたからの投稿ができなくなります' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*投稿機能について*\n --------------------------------------------- \n :eight_spoked_asterisk:  各ブロックの投稿 \n 各ブロックを1日に一度投稿することができるよ:star:\nみんなに共有したいことを投稿してみよう！\n --------------------------------------------- \n:sparkle:  毎日18時の自動投稿 \n毎日18時にチーム内の各ブロックを投稿するよ:star: \n あなたのブロックが選ばれたら嬉しいな！' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*Slashコマンドについて*\n本アプリでは以下のコマンドがSlack内で利用できるよ:hamster:' } }, { 'type': 'section', 'fields': [ { 'type': 'mrkdwn', 'text': ':information_source: `/prof_help` \nDMでヘルプメッセージを送るよ' }, { 'type': 'mrkdwn', 'text': ':postbox: `/prof_random_block` \n DMでランダムにブロックを1つ送るよ' } ] }, { 'type': 'section', 'fields': [ { 'type': 'mrkdwn', 'text': ':ok_hand: `/prof_activate_share` \n毎日18時の投稿を有効するよ' }, { 'type': 'mrkdwn', 'text': ':raised_back_of_hand: `/prof_deactivate_share` \n 毎日18時の投稿を止めるよ' } ] } ]"
    ERB::Util.url_encode(message)
  end
end
