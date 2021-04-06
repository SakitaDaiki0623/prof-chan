if Rails.env.test?
  Rails.application.config.middleware.use OmniAuth::Builder do
    on_failure { |env| Users::OmniauthCallbacksController.action(:failure).call(env) }
  end
end