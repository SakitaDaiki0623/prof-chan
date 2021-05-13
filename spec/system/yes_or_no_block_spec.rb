require 'rails_helper'

RSpec.describe "YesOrNoBlock", type: :system do

  let(:last_yes_or_no_block) { YesOrNoBlock.last }
  let(:yes_or_no_item_1)     { YesOrNoBlock.last.yes_or_no_items[0] }
  let(:yes_or_no_item_2)     { YesOrNoBlock.last.yes_or_no_items[1] }
  let(:yes_or_no_item_3)     { YesOrNoBlock.last.yes_or_no_items[2] }
  let(:words_over_fifty)      { 'あ' * 51 }

  let(:yes_or_no_block_title) { 'Yes or No ブロック タイトル' }
  let(:edit_yes_or_no_block_title) { 'Yes or No ブロック タイトル 編集済み' }
  let(:yes_or_no_item_content1) { 'Yes or No アイテム1 質問' }
  let(:edit_yes_or_no_item_content1) { 'Yes or No アイテム1 質問 編集済み' }
  let(:yes_or_no_item_content2) { 'Yes or No アイテム2 質問' }
  let(:yes_or_no_item_content3) { 'Yes or No アイテム3 質問' }

  let(:my_profile) { Profile.last }
  let(:others_profile) { Profile.second }

  # 編集画面まで遷移
  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
    find('#profile-edit-button').click
  end

  describe 'Yes or No ブロック作成機能' do

    describe 'Yes or No ブロック作成機能' do
      before do
        click_on 'Yes or No ブロックを追加する'
        expect(page).to have_content('Yes or No ブロック')
        expect(page).to have_button 'Yes or No ブロックを作成！', disabled: true
      end

      context '正常な値を入力した時' do
        before do
          fill_in 'yes_or_no_block_title', with:  yes_or_no_block_title
          within ("#create-yes-or-no-item-1") do
            fill_in 'yes_or_no_item[yes_or_no_item_content]', with: yes_or_no_item_content1
            find(".no-for-rspec").click
            find(".yes-for-rspec").click
          end
          expect(page).to have_button 'Yes or No ブロックを作成！', disabled: false
          click_on 'Yes or No ブロックを作成！'
          page.driver.browser.switch_to.alert.dismiss
        end

        it 'Yes or No ブロックが作成されること' do
          expect(page).to have_content(yes_or_no_block_title), 'Yes or No ブロックが作成されていません'
          expect(page).to have_content('Yes or No ブロックを作成したよ！'), 'フラッシュメッセージが表示されていません'
        end

        it '作成したブロックが詳細ページに反映されていること' do
          visit "/profiles/#{my_profile.id}"
          expect(page).to have_content(yes_or_no_block_title)
        end

        it '作成したブロックが他人の詳細ページに反映されていないこと' do
          visit "/profiles/#{others_profile.id}"
          expect(page).not_to have_content(yes_or_no_block_title)
        end

        it '作成ボタンがdisableに戻っていること' do
          click_on 'Yes or No ブロックを追加する'
          expect(page).to have_content('Yes or No ブロック')
          expect(page).to have_button 'Yes or No ブロックを作成！', disabled: true
        end
      end

      context 'タイトルが未入力の時' do
        before do
          fill_in 'yes_or_no_block_title', with:  ''
        end
        it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
          expect(page).to have_content(' タイトルを入力してね'), 'バリデーションメッセージが表示されていません'
          expect(page).to have_button 'Yes or No ブロックを作成！', disabled: true
        end
      end

      context 'タイトルが51文字以上の時' do
        before do
          fill_in 'yes_or_no_block_title', with: words_over_fifty
          sleep 0.5
          fill_in 'yes_or_no_block_title', with: words_over_fifty
        end
        it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
          expect(page).to have_content(' タイトルは最大50文字だよ'), 'バリデーションメッセージが表示されていません'
          expect(page).to have_button 'Yes or No ブロックを作成！', disabled: true
        end
      end

      context '1番目の質問が未入力の時' do
        before do
          within ("#create-yes-or-no-item-1") do
            fill_in 'yes_or_no_item[yes_or_no_item_content]', with: ''
          end
        end
        it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
          expect(page).to have_content('1番目の質問を入力してね'), 'バリデーションメッセージが表示されていません'
          expect(page).to have_button 'Yes or No ブロックを作成！', disabled: true
        end
      end

      context '1番目の質問が51文字以上の時' do
        before do
          within ("#create-yes-or-no-item-1") do
            fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: words_over_fifty
            sleep 0.5
            fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: words_over_fifty
          end
        end
        it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
          expect(page).to have_content('1番目の質問は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
          expect(page).to have_button 'Yes or No ブロックを作成！', disabled: true
        end
      end

      describe 'Yes or No アイテム追加・削除機能' do
        describe 'アイテム追加機能' do
          context 'アイテムを追加した時' do
            before do
              expect(page).to have_selector('#create-yes-or-no-item-1')
              expect(page).not_to have_selector('#create-yes-or-no-item-2')
              expect(page).not_to have_selector('#create-yes-or-no-item-3')
              find('#add-yes-or-no-item-button').click
            end
            it '2つめのアイテム入力フォームが表示されること' do
              expect(page).to have_selector('#create-yes-or-no-item-2')
            end

            it 'もう1度押すと3つめのアイテム入力フォームが表示されること' do
              find('#add-yes-or-no-item-button').click
              expect(page).to have_selector('#create-yes-or-no-item-3')
              expect(page).to have_button '質問と答えを追加する', disabled: true
            end
          end
        end

        describe 'アイテム削除機能' do
          context 'アイテムが2つある時' do
            before do
              find('#add-yes-or-no-item-button').click
              expect(page).to have_selector('#create-yes-or-no-item-2')
            end
            it 'アイテムを1つまで消すことができること' do
              find('#delete-yes-or-no-item-button').click
              expect(page).not_to have_selector('#create-yes-or-no-item-2')
            end
          end

          context 'アイテムが3つある時' do
            before do
              find('#add-yes-or-no-item-button').click
              find('#add-yes-or-no-item-button').click
              expect(page).to have_selector('#create-yes-or-no-item-2')
              expect(page).to have_selector('#create-yes-or-no-item-3')
            end
            it 'アイテムを2つまで消すことができること' do
              find('#delete-yes-or-no-item-button').click
              expect(page).not_to have_selector('#create-yes-or-no-item-3')
              find('#delete-yes-or-no-item-button').click
              expect(page).not_to have_selector('#create-yes-or-no-item-2')
            end
          end
        end

        describe 'アイテム数が3つ' do
          before do
            find('#add-yes-or-no-item-button').click
            find('#add-yes-or-no-item-button').click
            expect(page).to have_selector('#create-yes-or-no-item-2')
            expect(page).to have_selector('#create-yes-or-no-item-3')
          end
          context '全ての値を正常に入力した時' do
            before do
              fill_in 'yes_or_no_block_title', with:  yes_or_no_block_title
              within ("#create-yes-or-no-item-1") do
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: yes_or_no_item_content1
                # find(".no-for-rspec").click # デフォルトのYESを選択
              end
              within ("#create-yes-or-no-item-2") do
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: yes_or_no_item_content2
                find(".no-for-rspec").click
              end
              within ("#create-yes-or-no-item-3") do
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: yes_or_no_item_content3
                find(".no-for-rspec").click
              end
              expect(page).to have_button 'Yes or No ブロックを作成！', disabled: false
              click_on 'Yes or No ブロックを作成！'
              page.driver.browser.switch_to.alert.dismiss
            end
            it 'アイテム数が3つのYes or No ブロックが作成されること' do
              expect(page).to have_content(yes_or_no_block_title),   'Yes or No ブロックが作成されていません'
              expect(page).to have_selector 'span.border-red-500', text: 'YES'
              expect(page).to have_selector 'span.border-red-500', text: 'NO'
              expect(last_yes_or_no_block.yes_or_no_items.count).to eq(3), 'Yes or No ブロックのアイテム数が合っていません'
              expect(page).to have_content('Yes or No ブロックを作成したよ！'), 'フラッシュメッセージが表示されていません'
            end

            it '作成したブロックが詳細ページに反映されていること' do
              visit "/profiles/#{my_profile.id}"
              expect(page).to have_content(yes_or_no_block_title),   'Yes or No ブロックが作成されていません'
              expect(page).to have_selector 'span.border-red-500', text: 'YES'
              expect(page).to have_selector 'span.border-red-500', text: 'NO'
            end
          end

          context '全ての値が空値で入力された時' do
            before do
              fill_in 'yes_or_no_block_title', with:  ''
              within ("#create-yes-or-no-item-1") do
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: ''
              end
              within ("#create-yes-or-no-item-2") do
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: ''
              end
              within ("#create-yes-or-no-item-3") do
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: ''
              end
            end
            it "それぞれの空値のバリデーションメッセージが表示されること" do
              expect(page).to have_content(' タイトルを入力してね'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('1番目の質問を入力してね'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('2番目の質問を入力してね'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('3番目の質問を入力してね'), 'バリデーションメッセージが表示されていません'
            end
          end

          context '全ての値が50文字以上でで入力された時' do
            before do
              fill_in 'yes_or_no_block_title', with:  words_over_fifty
              sleep 0.5
              fill_in 'yes_or_no_block_title', with:  words_over_fifty
              within ("#create-yes-or-no-item-1") do
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: words_over_fifty
                sleep 0.5
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: words_over_fifty
              end
              within ("#create-yes-or-no-item-2") do
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: words_over_fifty
                sleep 0.5
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: words_over_fifty
              end
              within ("#create-yes-or-no-item-3") do
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: words_over_fifty
                sleep 0.5
                fill_in 'yes_or_no_item[yes_or_no_item_content]',	with: words_over_fifty
              end
            end
            it "それぞれの空値のバリデーションメッセージが表示されること" do
              expect(page).to have_content('タイトルは最大50文字だよ'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('1番目の質問は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('2番目の質問は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('3番目の質問は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
            end
          end
        end
      end
    end
  end

  describe 'Yes or No ブロック編集機能' do
    before do
      click_on 'Yes or No ブロックを追加する'
      fill_in 'yes_or_no_block_title', with:  yes_or_no_block_title
      within ("#create-yes-or-no-item-1") do
        fill_in 'yes_or_no_item[yes_or_no_item_content]', with: yes_or_no_item_content1
      end
      click_on 'Yes or No ブロックを作成！'
      page.driver.browser.switch_to.alert.dismiss
      sleep 1
      find("#edit-yes-or-no-block-button-#{last_yes_or_no_block.id}").click
      sleep 1
      expect(page).to have_content('Yes or No ブロックを編集'), 'Yes or No ブロック編集モーダルが表示されていません'
      expect(page).to have_content(yes_or_no_block_title),   '作成したYes or No ブロックのタイトルが表示されていません'
      expect(page).to have_content(yes_or_no_item_content1), '作成したYes or No ブロックの質問が表示されていません'
      expect(page).to have_selector 'span.border-red-500', text: 'YES'
    end
    describe '編集機能' do
      context 'タイトルを正常に編集した時' do
        before do
          find("#edit-yes-or-no-block-title-button-#{last_yes_or_no_block.id}").click
          expect(page).to have_selector("#edit-yes-or-no-title-form-#{last_yes_or_no_block.id}"), 'タイトル編集フォームがが表示されていません'
          fill_in "edit-yes-or-no-title-form-#{last_yes_or_no_block.id}", with:  edit_yes_or_no_block_title
          find("#update-yes-or-no-item-button-#{last_yes_or_no_block.id}").click
        end
        it 'タイトルが更新されること' do
          expect(page).to have_content(edit_yes_or_no_block_title), '更新したYes or No ブロックのタイトルが表示されていません'
          expect(YesOrNoBlock.last.title).to eq(edit_yes_or_no_block_title), 'タイトルが更新されていません' # DB上でも更新されているか確認
          expect(page).not_to have_selector("#edit-yes-or-no-title-form-#{last_yes_or_no_block.id}"), 'タイトル編集フォームがが表示されていません'
          expect(page).to have_content('Yes or No ブロックのタイトルを更新したよ！'), 'フラッシュメッセージが表示されていません'
        end


        it '作成したブロックが詳細ページに反映されていること' do
          visit "/profiles/#{my_profile.id}"
          expect(page).to have_content(edit_yes_or_no_block_title), '更新したYes or No ブロックのタイトルが表示されていません'
        end
      end

      context 'タイトルを入力して更新ボタンを押さずに編集をキャンセルした時' do
        before do
          find("#edit-yes-or-no-block-title-button-#{last_yes_or_no_block.id}").click
          fill_in "edit-yes-or-no-title-form-#{last_yes_or_no_block.id}", with:  edit_yes_or_no_block_title
          find("#cancel-yes-or-no-item-update-button-#{last_yes_or_no_block.id}").click
        end
        it '編集前のタイトルが表示されていること' do
          expect(page).to have_content(yes_or_no_block_title), '編集前のタイトルが表示されていません'
        end
      end

      context 'アイテムの質問と答えを正常に編集した時' do
        before do
          find("#edit-yes-or-no-item-button-#{yes_or_no_item_1.id}").click
          expect(page).to have_selector("#edit-yes-or-no-item-1"), 'アイテム編集フォームがが表示されていません'
          within ("#edit-yes-or-no-item-1") do
            fill_in 'yes_or_no_item[yes_or_no_item_content]', with: edit_yes_or_no_item_content1
            find(".no-for-rspec").click
          end
          sleep 2
          find("#update-yes-or-no-item-button-#{yes_or_no_item_1.id}").click
        end
        it 'アイテムが更新されること' do
          expect(page).to have_content(edit_yes_or_no_item_content1), '更新したYes or No ブロックのアイテムの質問が表示されていません'
          expect(page).to have_selector 'span.border-red-500', text: 'NO'
          expect(YesOrNoBlock.last.yes_or_no_items[0].content).to eq(edit_yes_or_no_item_content1), 'アイテムが更新されていません' # DB上でも更新されているか確認
          expect(page).to have_content('Yes or No アイテムを更新したよ！'), 'フラッシュメッセージが表示されていません'
        end

        it '作成したブロックが詳細ページに反映されていること' do
          visit "/profiles/#{my_profile.id}"
          expect(page).to have_content(edit_yes_or_no_item_content1), '更新したYes or No ブロックのアイテムの質問が表示されていません'
          expect(page).to have_selector 'span.border-red-500', text: 'NO'
        end
      end

      context 'アイテムを編集して更新ボタンを押さずにキャンセルした時' do
        before do

          find("#edit-yes-or-no-item-button-#{yes_or_no_item_1.id}").click
          within ("#edit-yes-or-no-item-1") do
            fill_in 'yes_or_no_item[yes_or_no_item_content]', with: edit_yes_or_no_item_content1
            find(".no-for-rspec").click
          end

          find("#cancel-yes-or-no-item-update-button-#{yes_or_no_item_1.id}").click
        end
        it '編集前のアイテムが表示されていること' do
          expect(page).to have_content(yes_or_no_item_content1), '編集前のアイテムが表示されていません'
          expect(page).to have_selector 'span.border-red-500', text: 'YES'
        end
      end
    end

    describe '作成機能' do
      context '正常に値を入力した場合' do
        before do
          expect(page).to have_selector('#individual-create-yes-or-no-block-item-form'), 'アイテム作成フォームが表示されていません'
          within ("#individual-create-yes-or-no-block-item-form") do
            fill_in 'yes_or_no_item[yes_or_no_item_content]', with: yes_or_no_item_content2
            find(".no-for-rspec").click
          end
          expect(page).to have_button '作成', disabled: false
          click_on '作成'
        end
        it '新しいアイテムが作成されること' do
          expect(page).to have_button '作成', disabled: true
          expect(page).to have_content(yes_or_no_item_content2), '2番目のアイテムの質問が作成されていません'
          expect(page).to have_selector 'span.border-red-500', text: 'NO'
        end
      end
      context '2つ作成した場合' do
        before do
          expect(page).to have_button '作成', disabled: true
          expect(page).to have_selector('#individual-create-yes-or-no-block-item-form'), 'アイテム作成フォームが表示されていません'
          within ("#individual-create-yes-or-no-block-item-form") do
            fill_in 'yes_or_no_item[yes_or_no_item_content]', with: yes_or_no_item_content2
            find(".no-for-rspec").click
          end
          expect(page).to have_button '作成', disabled: false
          click_on '作成'
          expect(page).to have_button '作成', disabled: true
          expect(page).to have_selector('#individual-create-yes-or-no-block-item-form'), 'アイテム作成フォームが表示されていません'
          within ("#individual-create-yes-or-no-block-item-form") do
            fill_in 'yes_or_no_item[yes_or_no_item_content]', with: yes_or_no_item_content3
            find(".no-for-rspec").click
          end
          expect(page).to have_button '作成', disabled: false
          click_on '作成'
        end
        it '新規作成フォームの表示が消えること' do
          expect(page).not_to have_selector('#individual-create-yes-or-no-block-item-form'), 'アイテム作成フォームが表示されています'
        end
      end
    end

    describe '削除機能' do
      before do
        expect(page).to have_button '作成', disabled: true
        expect(page).to have_selector('#individual-create-yes-or-no-block-item-form'), 'アイテム作成フォームが表示されていません'
        within ("#individual-create-yes-or-no-block-item-form") do
          fill_in 'yes_or_no_item[yes_or_no_item_content]', with: yes_or_no_item_content2
          find(".no-for-rspec").click
        end
        expect(page).to have_button '作成', disabled: false
        click_on '作成'
        expect(page).to have_content(yes_or_no_item_content2), '2番目のアイテムの質問が作成されていません'
        expect(page).to have_selector 'span.border-red-500', text: 'YES'
      end
      context '一つのアイテムを削除した場合' do
        before do
          within ("#edit-yes-or-no-item-2") do
            expect(page).to have_selector("#delete-yes-or-no-item-button-#{yes_or_no_item_2.id}")
            find("#delete-yes-or-no-item-button-#{yes_or_no_item_2.id}").click
            page.driver.browser.switch_to.alert.accept
          end
        end
        it 'アイテムが1つ消えること' do
          expect(page).not_to have_content(yes_or_no_item_content2), '2番目のアイテムの質問が表示されています'
        end

        it '作成したブロックが詳細ページに反映されていること' do
          visit "/profiles/#{my_profile.id}"
          expect(page).not_to have_content(yes_or_no_item_content2), '2番目のアイテムの質問が表示されています'
        end
      end
      context 'アイテムが3つある状態で1つアイテムを削除する場合' do
        before do
          within ("#individual-create-yes-or-no-block-item-form") do
            fill_in 'yes_or_no_item[yes_or_no_item_content]', with: yes_or_no_item_content3
            find(".no-for-rspec").click
          end
          click_on '作成'
          sleep 1 # DBへの反映を待つ
          expect(YesOrNoBlock.last.yes_or_no_items.count).to eq(3)
          expect(page).not_to have_selector('#individual-create-yes-or-no-block-item-form'), 'アイテム作成フォームが表示されています'

          within ("#edit-yes-or-no-item-3") do
            expect(page).to have_selector("#delete-yes-or-no-item-button-#{yes_or_no_item_3.id}")
            find("#delete-yes-or-no-item-button-#{yes_or_no_item_3.id}").click
            page.driver.browser.switch_to.alert.accept
          end
        end
        it '新規作成フォームが表示されること' do
          expect(page).to have_selector('#individual-create-yes-or-no-block-item-form'), 'アイテム作成フォームが表示されています'
        end
      end
    end
  end

  describe 'Yes or No ブロック削除機能' do
    before do
      click_on 'Yes or No ブロックを追加する'
      fill_in 'yes_or_no_block_title', with:  yes_or_no_block_title
      within ("#create-yes-or-no-item-1") do
        fill_in 'yes_or_no_item[yes_or_no_item_content]', with: yes_or_no_item_content1
        find(".no-for-rspec").click
      end
      click_on 'Yes or No ブロックを作成！'
      page.driver.browser.switch_to.alert.dismiss
    end
    context '削除ボタンを押してconfirmダイアログで「OK」を選択した時' do
      before do
        sleep 1
        find("#delete-yes-or-no-block-button-#{last_yes_or_no_block.id}").click
        page.driver.browser.switch_to.alert.accept # confirmダイアログで「OK」を選択する
      end
      it '対象のYes or No ブロックが削除されること' do
        expect(page).not_to have_content(yes_or_no_block_title), '対象のYes or No ブロックが削除されていません'
        expect(page).to have_content('Yes or No ブロックを削除したよ！'), 'フラッシュメッセージが表示されていません'
      end
    end

    context '削除ボタンを押してconfirmダイアログで「キャンセル」を選択した時' do
      before do
        sleep 1
        find("#delete-yes-or-no-block-button-#{last_yes_or_no_block.id}").click
        page.driver.browser.switch_to.alert.dismiss # confirmダイアログで「キャンセル」を選択する
      end
      it '対象のYes or No ブロックが削除されないこと' do
        expect(page).to have_content(yes_or_no_block_title), '対象のYes or No ブロックが削除されています'
        expect(page).not_to have_content('Yes or No ブロックを削除したよ！'), 'フラッシュメッセージが表示されています'
      end
    end
  end
end
