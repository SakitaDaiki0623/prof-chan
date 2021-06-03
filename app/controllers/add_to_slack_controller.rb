# # app/controllers/add_to_slack_controller.rb
# class AddToSlackController < ApplicationController
#   skip_before_action :authenticate_user!

#   def callback
#     client = Slack::Web::Client.new
#     begin
#       binding.pry
#       response = client.oauth_v2_access(
#         {
#           client_id: ENV['SLACK_CLIENT_ID'],
#           client_secret: ENV['SLACK_CLIENT_SECRET'],
#           redirect_uri: "https://6ecc3408d7a1.ngrok.io/auth/callback",
#           code: params[:code]
#         }
#       )
#       # Success:
#       # Yay! Auth succeeded! Let's store the tokens and create a Slack client to use in our Events handlers.
#       # The tokens we receive are used for accessing the Web API, but this process also creates the Team's bot user and
#       # authorizes the app to access the Team's Events.
#       team_id = response['team_id']
#       $teams[team_id] = {
#         user_access_token: response['access_token'],
#         bot_user_id: response['bot']['bot_user_id'],
#         bot_access_token: response['bot']['bot_access_token']
#       }

#       $teams[team_id]['client'] = create_slack_client(response['bot']['bot_access_token'])
#     rescue Slack::Web::Api::Error => e
#       # Failure:
#       # D'oh! Let the user know that something went wrong and output the error message returned by the Slack client.
#       status 403
#       body "Auth failed! Reason: #{e.message}<br/>#{add_to_slack_button}"
#     end

#     if current_user.update_attributes(
#       slack_access_token: response['access_token'],
#       slack_incoming_webhook_url: response['incoming_webhook']['url']
#     )
#       redirect_to root_path
#     else
#       render text: "Oops! There was a problem."
#     end
#   end
# end