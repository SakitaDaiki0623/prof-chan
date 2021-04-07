# [参考]https://github.com/yukihirop/GrapeSlack/blob/master/spec/support/omniauth_helper.rb
# spec/support/omniauth_helper.rb
# TODO: API認証時のテストを追加(未実装)
module OmniauthHelpers
  def set_slack_omniauth
    OmniAuth.config.mock_auth[:slack] =
        OmniAuth::AuthHash.new(
            {
                'provider'  => 'slack',
                'uid'       => 'mock_uid_1234',
                },
        )
  end

  def set_user_info
    user_info = {
      "user"=>
        {"name"=>Faker::Name.name,
        "email"=>Faker::Internet.email,
        "image_192"=>
        "https://secure.gravatar.com/avatar/194be25cf4ea9d48e5fe8559a718043d.jpg?s=192&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0016-192.png",},
      "team"=>
        {"id"=>rand(10 ** 19).to_s,
        "name"=>"show_profile_development",
        "image_230"=>"https://avatars.slack-edge.com/2021-03-08/1825255374918_7955fb79fef81b734c2a_230.jpg",
        }
    }
    user_info
  end

  def set_invalid_omniauth
    OmniAuth.config.mock_auth[:slack] = :invalid_credentials
  end
end
