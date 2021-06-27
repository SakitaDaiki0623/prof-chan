require 'rails_helper'

RSpec.describe "お試し版ログイン", type: :system do
  let(:user) { create(:user) }

  describe "新規登録画面" do
    before do
      visit root_path
      find('#new-registration-button').click
      expect(page).to have_content('ユーザ登録')
    end
    context '正常な値を入れて登録した時' do
      before do
        fill_in 'user_name',	with: user.name
        fill_in 'user_email',	with: user.email
        fill_in 'user_password',	with: user.password
        fill_in 'user_password_confirmation',	with: user.password
        attach_file "user_image", "spec/fixtures/images/prof_normal.png"
        check "user_agreement"
        find('#complete-registration-button').click
      end
      it "新規登録画面に遷移すること" do
        expect(current_path).to eq(new_profile_path)
      end
    end
    context "全て空値で登録しようとした時" do
      before { find('#complete-registration-button').click }
      it "バリデーションメッセージが表示されること" do
        expect(page).to have_content('名前を入力してください')
        expect(page).to have_content('画像を入力してください')
        expect(page).to have_content('Eメールを入力してください')
        expect(page).to have_content('暗号化パスワードを入力してください')
        expect(page).to have_content('規約を受諾してください')
      end
    end
  end

  describe "ログイン画面" do
    before do
      visit root_path
      find('#to-login-button').click
    end
    context "新規登録した後にログアウトしログイン画面で正常な値を入れた時" do
      before do
        fill_in 'user_email',	with: user.email
        fill_in 'user_password',	with: user.password
        find('#login-button').click
      end
      it "正常にログインできること" do
        expect(current_path).to eq(top_path)
      end
    end
    context "全て空値で登録しようとした時" do
      before { find('#login-button').click }
      it "バリデーションメッセージが表示されること" do
        expect(page).to have_content('Eメールまたはパスワードが違います。')
      end
    end
  end
end
