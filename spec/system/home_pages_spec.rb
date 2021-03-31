require 'rails_helper'

RSpec.describe "HomePages", type: :system do

  context 'ホームページにアクセス' do
    before { visit root_path }
    it 'slackログインボタンが表示されていること' do
      expect(page).to have_content('Slackログイン'), '「Slackログイン」ボタンが表示されていません'
    end
  end

  describe 'ログイン前' do
    context 'プロフィール新規作成画面にアクセス' do
      before { visit new_profile_path }
      it 'ホームページにリダイレクトされること' do
        expect(current_path).to eq(root_path), 'ホームページにリダイレクトされていません'
      end
    end

    context 'プロフィール一覧画面にアクセス' do
      before { visit new_profile_path }
      it 'ホームページにリダイレクトされること' do
        expect(current_path).to eq(root_path), 'ホームページにリダイレクトされていません'
      end
    end
  end
end
