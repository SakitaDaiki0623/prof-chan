module SlackApiActivatable

  def get_user_info(user_token)
    user_token.get('/api/users.identity').parsed
  end

  def create_channel(info, bot_token)
    set_client
    token = bot_token.token
    workspace_id = info.dig('team', 'id')

    uri = URI.parse('https://slack.com/api/conversations.list?pretty=1')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    header = {'Authorization': 'Bearer ' + token, 'Content-type': 'application/x-www-form-urlencoded'}

    return if Team.exists?(workspace_id: workspace_id)

  end

  def set_client
    client = Slack::Web::Client.new
  end
end