# https://github.com/heartcombo/devise/wiki/How-To:-Redirect-to-a-specific-page-when-the-user-can-not-be-authenticated
# lib/custom_failure.rb
class CustomFailure < Devise::FailureApp
  def redirect_url
    root_url
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect_to root_path
    end
  end
end
