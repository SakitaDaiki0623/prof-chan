class Slack::Settings::ShareController < Slack::ApplicationController
  before_action :set_user, only: %i[activate deactivate]

  def activate
    if @user.nil?
      send_please_login_msg
    else
      @team = Team.find_by(workspace_id: params[:team_id])
      access_token = set_access_token(@user.authentication.access_token)
      if @team.share_right_inactive?
        @team.share_right_active!
        channel_id = @team.share_channel_id
        text = "<#{@user.uid}>が毎日18時の投稿をONにしたよ:hamster:"
        encoded_text = ERB::Util.url_encode(text)
        encoded_msg = activate_msg(@user)
        res = access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
        p res
      else
        text = "既に18時の投稿はONだよ:hamster:"
        encoded_text = ERB::Util.url_encode(text)
        encoded_msg = already_activated_msg(@user)
        access_token.post("api/chat.postMessage?channel=#{@user.uid}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
      end
    end
  end

  def deactivate
    if @user.nil?
      send_please_login_msg
    else
      @team = Team.find_by(workspace_id: params[:team_id])
      access_token = set_access_token(@user.authentication.access_token)
      if @team.share_right_active?
        @team.share_right_inactive!
        channel_id = @team.share_channel_id
        text = "<#{@user.uid}>が毎日18時の投稿をOFFにしたよ:hamster:"
        encoded_text = ERB::Util.url_encode(text)
        encoded_msg = deactivate_msg(@user)
        res = access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
        p res
      else
        text = "既に18時の投稿はOFFだよ:hamster:"
        encoded_text = ERB::Util.url_encode(text)
        encoded_msg = already_deactivated_msg(@user)
        access_token.post("api/chat.postMessage?channel=#{@user.uid}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
      end
    end
  end

  def activate_msg(_user)
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '<@#{@user.uid}>が毎日18時の投稿をONにしたよ:hamster:' } }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '投稿機能を停止する時は `/prof_deactivate_share` コマンドを使用してね' } }, { 'type': 'divider' }, { 'type': 'divider' } ]"
    encoded_msg = ERB::Util.url_encode(msg)
    encoded_msg
  end

  def already_activated_msg(_user)
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '<@#{@user.uid}> \n  `/prof_activate_share` が実行されましたが既に18時の投稿はONになっています。:hamster:' } }, { 'type': 'divider' }, { 'type': 'divider' } ]"
    encoded_msg = ERB::Util.url_encode(msg)
    encoded_msg
  end

  def deactivate_msg(user)
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '<@#{user.uid}>が毎日18時の投稿をOFFにしたよ:hamster:' } }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '投稿機能を元に戻す時は `/prof_activate_share` コマンドを使用してね' } }, { 'type': 'divider' }, { 'type': 'divider' } ]"
    encoded_msg = ERB::Util.url_encode(msg)
    encoded_msg
  end

  def already_deactivated_msg(_user)
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '<@#{@user.uid}> \n  `/prof_deactivate_share` が実行されましたが既に18時の投稿はOFFになっています。:hamster:' } }, { 'type': 'divider' }, { 'type': 'divider' } ]"
    encoded_msg = ERB::Util.url_encode(msg)
    encoded_msg
  end

  def set_user
    @user = User.find_by(uid: params[:user_id])
  end
end
