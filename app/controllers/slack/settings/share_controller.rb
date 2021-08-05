class Slack::Settings::ShareController < Slack::ApplicationController
  before_action :set_user_team_token, only: %i[activate inactivate]

  def activate
    if @team.share_right_inactive?
      @team.share_right_active!
      @encoded_msg = activate_msg(@user)
      @access_token.post("api/chat.postMessage?channel=#{@channel_id}&blocks=#{@encoded_msg}&text=#{@encoded_text}&pretty=1").parsed
    else
      @encoded_msg = already_activated_msg(@user)
      @access_token.post("api/chat.postMessage?channel=#{@user.uid}&blocks=#{@encoded_msg}&text=#{@encoded_text}&pretty=1").parsed
    end
  end

  def inactivate
    if @team.share_right_active?
      @team.share_right_inactive!
      @encoded_msg = inactivate_msg(@user)
      @access_token.post("api/chat.postMessage?channel=#{@channel_id}&blocks=#{@encoded_msg}&text=#{@encoded_text}&pretty=1").parsed
    else
      @encoded_msg = already_inactivated_msg(@user)
      @access_token.post("api/chat.postMessage?channel=#{@user.uid}&blocks=#{@encoded_msg}&text=#{@encoded_text}&pretty=1").parsed
    end
  end

  def set_user_team_token
    @team = Team.find_by(workspace_id: params[:team_id])
    @user = User.find_by(uid: params[:user_id])
    return unless @team.workspace_id == @user.team.workspace_id

    @text = "<#{@user.uid}>が毎日18時の投稿をONにしたよ:hamster:"
    @encoded_text = ERB::Util.url_encode(@text)
    @channel_id = @team.share_channel_id
    @access_token = set_access_token(@user.authentication.access_token)
  end

  def activate_msg(_user)
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '<@#{@user.uid}>が毎日18時の投稿をONにしたよ:hamster:' } }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '投稿機能を停止する時は `/prof_inactivate_share` コマンドを使用してね' } }, { 'type': 'divider' }, { 'type': 'divider' } ]"
    encoded_msg = ERB::Util.url_encode(msg)
    encoded_msg
  end

  def already_activated_msg(_user)
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '<@#{@user.uid}> \n  `/prof_activate_share` が実行されましたが既に18時の投稿はONになっています。:hamster:' } }, { 'type': 'divider' }, { 'type': 'divider' } ]"
    encoded_msg = ERB::Util.url_encode(msg)
    encoded_msg
  end

  def inactivate_msg(user)
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '<@#{user.uid}>が毎日18時の投稿をOFFにしたよ:hamster:' } }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '投稿機能を元に戻す時は `/prof_activate_share` コマンドを使用してね' } }, { 'type': 'divider' }, { 'type': 'divider' } ]"
    encoded_msg = ERB::Util.url_encode(msg)
    encoded_msg
  end

  def already_inactivated_msg(_user)
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '<@#{@user.uid}> \n  `/prof_inactivate_share` が実行されましたが既に18時の投稿はOFFになっています。:hamster:' } }, { 'type': 'divider' }, { 'type': 'divider' } ]"
    encoded_msg = ERB::Util.url_encode(msg)
    encoded_msg
  end
end
