class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # helper TailwindHelper

  # Divise認証時に分岐
  # TODO: フラッシュメッセージが反映されない
  def after_sign_in_path_for(user)
    if user.profile
      flash[:notice] = 'ログインに成功しました'
      profiles_path
    else
      flash[:notice] = '新規登録完了しました。次にプロフィールを作成してください'
      new_profile_path
    end
  end
end
