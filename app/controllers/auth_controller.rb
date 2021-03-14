# app/controllers/auth_controller.rb
class AuthController < ApplicationController
  def callback
    render plain: { access_token: request.env['omniauth.strategy'].access_token.to_hash,
      auth_hash:  request.env['omniauth.auth']
    }.to_yaml
  end
end
