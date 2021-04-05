class ApiController < ActionController::API
  protect_from_forgery with: :null_session
end
