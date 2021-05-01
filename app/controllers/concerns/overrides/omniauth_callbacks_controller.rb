# app/controllers/concerns/overrides/omniauth_callbacks_controller.rb
module Overrides

  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController

    def redirect_callbacks
      super
    end

    def omniauth_success
      super
    end

    def omniauth_failure
      super
    end

    protected
    def assign_provider_attrs(user, auth_hash)
      case auth_hash['provider']
      when 'slack'
        user.assign_attributes({
          nickname: auth_hash['info']['nickname'],
          name: auth_hash['info']['name'],
          image: auth_hash['info']['image'],
          email: auth_hash['info']['email']
        })
      else
        super
      end
    end
  end
end
