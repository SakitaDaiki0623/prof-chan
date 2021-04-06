class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_profile_nil

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

  def check_profile_nil
    if current_user.profile.nil?
      flash[:alert] = 'まずは基本情報を作ろう！'
      redirect_to new_profile_path
    end
  end
end
