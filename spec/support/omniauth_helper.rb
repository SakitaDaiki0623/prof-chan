# [参考]https://github.com/yukihirop/GrapeSlack/blob/master/spec/support/omniauth_helper.rb
# spec/support/omniauth_helper.rb
# TODO: API認証時のテストを追加(未実装)
module OmniauthHelpers
  def set_omniauth
    OmniAuth.config.mock_auth[:slack] =
        OmniAuth::AuthHash.new(
            {
                'provider'  => 'slack',
                'uid'       => 'mock_uid_1234',
                'credentials' => {
                  'token' => 'mock_credentails_token',
                },
            }
        )
  end

  def set_user_info

  end

  def set_invalid_omniauth
    OmniAuth.config.mock_auth[:slack] = :invalid_credentials
  end
end
