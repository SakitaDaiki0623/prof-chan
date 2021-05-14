# spec/system/ranking_block_spec.rb
require 'rails_helper'

RSpec.describe 'RankingBlock', type: :system do

  let(:ranking_block) { RankingBlock.last }
  let!(:factory_ranking_block) { create(:ranking_block) }

  let(:my_profile) { Profile.last }
  let(:others_profile) { Profile.second }

  let(:words_over_fifty)      { 'あ' * 51 }

  # 編集画面まで遷移
  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_top_path
    find('#profile-edit-button').click
  end

  describe 'ランキングブロック作成機能' do
    context '正常な値を入力した時' do
      before do
        click_on 'ランキングブロックを追加する'
        expect(page).to have_button 'ランキングブロックを作成！', disabled: true
        fill_in 'ranking_block_title',	with: factory_ranking_block.title
        fill_in 'ranking_block_first_place',	with: factory_ranking_block.first_place
        fill_in 'ranking_block_second_place',	with: factory_ranking_block.second_place
        fill_in 'ranking_block_third_place',	with: factory_ranking_block.third_place
        expect(page).to have_button 'ランキングブロックを作成！', disabled: false
        click_on 'ランキングブロックを作成！'
        page.driver.browser.switch_to.alert.dismiss
      end
      it 'ランキングブロックが作成されること' do
        expect(page).to have_content(factory_ranking_block.title),        'ランキングブロックが作成されていません'
        expect(page).to have_content(factory_ranking_block.first_place),  'ランキングブロックが作成されていません'
        expect(page).to have_content(factory_ranking_block.second_place), 'ランキングブロックが作成されていません'
        expect(page).to have_content(factory_ranking_block.third_place),  'ランキングブロックが作成されていません'
        expect(page).to have_content('ランキングブロックを作成したよ！'), 'フラッシュメッセージが表示されていません'
      end

      it '作成したブロックが詳細ページに反映されていること' do
        visit "/profiles/#{my_profile.id}"
        expect(page).to have_content(factory_ranking_block.title),        'ランキングブロックが作成されていません'
        expect(page).to have_content(factory_ranking_block.first_place),  'ランキングブロックが作成されていません'
        expect(page).to have_content(factory_ranking_block.second_place), 'ランキングブロックが作成されていません'
        expect(page).to have_content(factory_ranking_block.third_place),  'ランキングブロックが作成されていません'
      end

      it '作成したブロックが他人の詳細ページに反映されていないこと' do
        visit "/profiles/#{others_profile.id}"
        expect(page).not_to have_content(factory_ranking_block.title),        'ランキングブロックが作成されていません'
        expect(page).not_to have_content(factory_ranking_block.first_place),  'ランキングブロックが作成されていません'
        expect(page).not_to have_content(factory_ranking_block.second_place), 'ランキングブロックが作成されていません'
        expect(page).not_to have_content(factory_ranking_block.third_place),  'ランキングブロックが作成されていません'
      end

      it '作成ボタンがdisableに戻っていること' do
        click_on 'ランキングブロックを追加する'
        expect(page).to have_button 'ランキングブロックを作成！', disabled: true
      end
    end

    context 'タイトルが未入力の時' do
      before do
        click_on 'ランキングブロックを追加する'
        fill_in 'ranking_block_title',	with: ''
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('タイトルを入力してね'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'ランキングブロックを作成！', disabled: true
      end
    end

    context 'タイトルが51文字以上の時' do
      before do
        click_on 'ランキングブロックを追加する'
        fill_in 'ranking_block_title', with: words_over_fifty
        sleep 0.5
        fill_in 'ranking_block_title', with: words_over_fifty
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('タイトルは最大50文字だよ'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'ランキングブロックを作成！', disabled: true
      end
    end

    context '1位が未入力の時' do
      before do
        click_on 'ランキングブロックを追加する'
        fill_in 'ranking_block_first_place', with: ''
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('1位を入力してね'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'ランキングブロックを作成！', disabled: true
      end
    end

    context '1位が51文字以上の時' do
      before do
        click_on 'ランキングブロックを追加する'
        fill_in 'ranking_block_first_place', with: words_over_fifty
        sleep 0.5
        fill_in 'ranking_block_first_place', with: words_over_fifty
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('1位は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'ランキングブロックを作成！', disabled: true
      end
    end

    context '2位が未入力の時' do
      before do
        click_on 'ランキングブロックを追加する'
        fill_in 'ranking_block_second_place', with: ''
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('2位を入力してね'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'ランキングブロックを作成！', disabled: true
      end
    end

    context '2位が51文字以上の時' do
      before do
        click_on 'ランキングブロックを追加する'
        fill_in 'ranking_block_second_place', with: words_over_fifty
        sleep 0.5
        fill_in 'ranking_block_second_place', with: words_over_fifty
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('2位は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'ランキングブロックを作成！', disabled: true
      end
    end

    context '3位が未入力の時' do
      before do
        click_on 'ランキングブロックを追加する'
        fill_in 'ranking_block_third_place', with: ''
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('3位を入力してね'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'ランキングブロックを作成！', disabled: true
      end
    end

    context '3位が51文字以上の時' do
      before do
        click_on 'ランキングブロックを追加する'
        fill_in 'ranking_block_third_place', with: words_over_fifty
        sleep 0.5
        fill_in 'ranking_block_third_place', with: words_over_fifty
      end
      it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
        expect(page).to have_content('3位は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
        expect(page).to have_button 'ランキングブロックを作成！', disabled: true
      end
    end
  end

  describe 'ランキングブロック編集・削除機能' do
    before do
      click_on 'ランキングブロックを追加する'
      fill_in 'ranking_block_title',	with: factory_ranking_block.title
      fill_in 'ranking_block_first_place',	with: factory_ranking_block.first_place
      fill_in 'ranking_block_second_place',	with: factory_ranking_block.second_place
      fill_in 'ranking_block_third_place',	with: factory_ranking_block.third_place
      click_on 'ランキングブロックを作成！'
      page.driver.browser.switch_to.alert.dismiss
    end
    context 'ランキングブロックを更新した時' do
      before do
        find("#edit-ranking-block-button-#{ranking_block.id}").click
        expect(page).to have_content('ランキングブロックを編集'), 'ランキングブロック編集ダイアログが表示されていません'
        fill_in 'ranking_block_title',	with: '編集されたタイトル'
        fill_in 'ranking_block_first_place',  with: '編集されたランキング1位'
        fill_in 'ranking_block_second_place', with: '編集されたランキング2位'
        fill_in 'ranking_block_third_place',  with: '編集されたランキング3位'
        click_on 'ランキングブロックを更新！'
      end
      it 'ランキングブロックの値が更新されていること' do
        expect(page).to have_content('編集されたタイトル'),      'タイトルが更新されていません'
        expect(page).to have_content('編集されたランキング1位'), '1位が更新されていません'
        expect(page).to have_content('編集されたランキング2位'), '2位が更新されていません'
        expect(page).to have_content('編集されたランキング3位'), '3位が更新されていません'
        expect(page).to have_content('ランキングブロックを更新したよ！'), 'フラッシュメッセージが表示されていません'
      end

      it '編集したブロックが詳細ページに反映されていること' do
        visit "/profiles/#{my_profile.id}"
        expect(page).to have_content('編集されたタイトル'),      'タイトルが更新されていません'
        expect(page).to have_content('編集されたランキング1位'), '1位が更新されていません'
        expect(page).to have_content('編集されたランキング2位'), '2位が更新されていません'
        expect(page).to have_content('編集されたランキング3位'), '3位が更新されていません'
      end

      it '編集したブロックが他人の詳細ページに反映されていないこと' do
        visit "/profiles/#{others_profile.id}"
        expect(page).not_to have_content('編集されたタイトル'),      'タイトルが更新されていません'
        expect(page).not_to have_content('編集されたランキング1位'), '1位が更新されていません'
        expect(page).not_to have_content('編集されたランキング2位'), '2位が更新されていません'
        expect(page).not_to have_content('編集されたランキング3位'), '3位が更新されていません'
      end
    end

    context '削除ボタンを押してconfirmダイアログで「OK」を選択した時' do
      before do
        find("#delete-ranking-block-button-#{ranking_block.id}").click
        page.driver.browser.switch_to.alert.accept # confirmダイアログで「OK」を選択する
      end
      it '対象のランキングブロックが削除されること' do
        expect(page).not_to have_content(ranking_block.title), '対象のランキングブロックが削除されていません'
        expect(page).to have_content('ランキングブロックを削除したよ！'), 'フラッシュメッセージが表示されていません'
      end
    end

    context '削除ボタンを押してconfirmダイアログで「キャンセル」を選択した時' do
      before do
        find("#delete-ranking-block-button-#{ranking_block.id}").click
        page.driver.browser.switch_to.alert.dismiss # confirmダイアログで「キャンセル」を選択する
      end
      it '対象のランキングブロックが削除されないこと' do
        expect(page).to have_content(ranking_block.title),                    '対象のランキングブロックが削除されています'
        expect(page).not_to have_content('ランキングブロックを削除したよ！'), 'フラッシュメッセージが表示されています'
      end
    end
  end
end
