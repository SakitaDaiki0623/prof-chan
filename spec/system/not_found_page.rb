require 'rails_helper'

RSpec.describe 'NotFoundPage', type: :system do


  describe 'ログイン後' do
    describe 'プロフ一覧画面' do
      before do
        create_normal_team_with_users(users_count: 3)
        create_real_team_with_users(users_count: 3)
        login
      end
      context '存在しないURLにアクセスした時' do
        before { visit '/profiles/404test' }
        it '404ページに遷移すること' do
          expect(page).to have_content('404 NotFound'), '404ページが表示されていません'
        end
      end
    end
  end
end
