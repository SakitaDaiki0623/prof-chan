# spec/controllers/omniauth_callbacks_controller_spec.rb

require 'rails_helper'

describe "OmniauthCallbacksController" do
  let(:response_body) { [{
    "user": {
      "name": "kurukuruskt28",
      "email": "kurukuruskt28@gmail.com",
      "image_192": "https://secure.gravatar.com/avatar/194be25cf4ea9d48e5fe8559a718043d.jpg?s=192&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0016-192.png"
    },
    "team": {
      "id": "T01QG6RRLUT",
      "name": "show_profile_development",
      "image_230": "https://avatars.slack-edge.com/2021-03-08/1825255374918_7955fb79fef81b734c2a_230.jpg"
    }
  }].to_json }

  before do
    WebMock.enable!
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = slack_omniauth
  end

  describe 'get_user_info' do
    before do
      WebMock.stub_request(:get, "https://slack.com/api/users.identity").to_return(
        body: response_body,
        status: 200,
        headers: { 'Content-Type' =>  'application/json' }
      )
    end

    fit 'returns 200 status' do
      # expect(a_request(:get, "https://example.com")).to have_been_made.once

      binding.pry
      
    end
  end
end
