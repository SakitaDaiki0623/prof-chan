class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # helper TailwindHelper

  def get_user_info(request)
    request.access_token.user_token.get('/api/users.identity').parsed
  end

  # Divise認証時に分岐
  def after_sign_in_path_for(user)
    if user.profile
      flash[:notice] = 'ログインに成功しました'
      profiles_path
    else
      flash[:notice] = '新規登録完了しました。次にプロフィールを作成してください。'
      new_profile_path
    end
  end
end
