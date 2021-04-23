require 'rails_helper'

RSpec.describe "QuestionBlocks", type: :system do

  let(:last_question_block) { QuestionBlock.last }
  let(:question_item_1)     { QuestionBlock.last.question_items[0] }
  let(:question_item_2)     { QuestionBlock.last.question_items[1] }
  let(:question_item_3)     { QuestionBlock.last.question_items[2] }
  let(:words_over_fifty)      { 'あ' * 51 }

  let(:question_block_title) { 'クエスチョンブロック タイトル' }
  let(:edit_question_block_title) { 'クエスチョンブロック タイトル 編集済み' }
  let(:question_item_content1) { 'クエスチョンアイテム1 質問' }
  let(:question_item_answer1) { 'クエスチョンアイテム1 回答' }
  let(:edit_question_item_content1) { 'クエスチョンアイテム1 質問 編集済み' }
  let(:edit_question_item_answer1) { 'クエスチョンアイテム1 回答 編集済み' }
  let(:question_item_content2) { 'クエスチョンアイテム2 質問' }
  let(:question_item_answer2) { 'クエスチョンアイテム2 回答' }
  let(:question_item_content3) { 'クエスチョンアイテム3 質問' }
  let(:question_item_answer3) { 'クエスチョンアイテム3 回答' }

  # 編集画面まで遷移
  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
    find('#profile-edit-button').click
  end

  describe 'クエスチョンブロック作成機能' do

    describe 'フォーマット選択ダイアログ' do
      before { click_on 'クエスチョンブロックを追加する' }
      it 'フォーマット選択ダイアログが表示されること' do
        expect(page).to have_content('フォーマットを選択してください'), 'フォーマット選択ダイアログが表示されていません'
      end

      context '✖︎ボタンを押した時' do
        before { find('#close-question-block-select-dialog').click }
        it 'フォーマット選択ダイアログが非表示になること' do
          expect(page).not_to have_content('フォーマットを選択してください'), 'フォーマット選択ダイアログが表示されています'
        end
      end
    end

    describe 'クエスチョンブロック作成機能' do
      before do
        click_on 'クエスチョンブロックを追加する'
        sleep 1
        find('#open-create-original-question-format-dialog').click
        expect(page).to have_content('クエスチョンブロック')
        expect(page).to have_button 'クエスチョンブロックを作成！', disabled: true
      end

      context '正常な値を入力した時' do
        before do
          fill_in 'question_block_title', with:  question_block_title
          within ("#create-question-item-1") do
            fill_in 'question_item[question_item_content]', with: question_item_content1
            fill_in 'question_item[question_item_answer]',  with:  question_item_answer1
          end
          expect(page).to have_button 'クエスチョンブロックを作成！', disabled: false
          click_on 'クエスチョンブロックを作成！'
        end

        it 'クエスチョンブロックが作成されること' do
          expect(page).to have_content(question_block_title), 'クエスチョンブロックが作成されていません'
          expect(page).to have_content('クエスチョンブロックを作成したよ！'), 'フラッシュメッセージが表示されていません'
        end

        it '作成ボタンがdisableに戻っていること' do
          click_on 'クエスチョンブロックを追加する'
          find('#open-create-original-question-format-dialog').click
          expect(page).to have_content('クエスチョンブロック')
          expect(page).to have_button 'クエスチョンブロックを作成！', disabled: true
        end
      end

      context 'タイトルが未入力の時' do
        before do
          fill_in 'question_block_title', with:  ''
          within ("#create-question-item-1") do
            fill_in 'question_item[question_item_content]', with:  question_item_content1
            fill_in 'question_item[question_item_answer]',  with:  question_item_answer1
          end
        end
        it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
          expect(page).to have_content(' タイトルを入力してね'), 'バリデーションメッセージが表示されていません'
          expect(page).to have_button 'クエスチョンブロックを作成！', disabled: true
        end
      end

      context 'タイトルが51文字以上の時' do
        before do
          fill_in 'question_block_title', with: words_over_fifty
        end
        it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
          expect(page).to have_content(' タイトルは最大50文字だよ'), 'バリデーションメッセージが表示されていません'
          expect(page).to have_button 'クエスチョンブロックを作成！', disabled: true
        end
      end

      context '1番目の質問が未入力の時' do
        before do
          fill_in 'question_block_title', with:  question_block_title
          within ("#create-question-item-1") do
            fill_in 'question_item[question_item_content]', with: ''
            fill_in 'question_item[question_item_answer]',  with:  question_item_answer1
          end
        end
        it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
          expect(page).to have_content('1番目の質問を入力してね'), 'バリデーションメッセージが表示されていません'
          expect(page).to have_button 'クエスチョンブロックを作成！', disabled: true
        end
      end

      context '1番目の質問が51文字以上の時' do
        before do
          fill_in 'question_block_title', with:  question_block_title
          within ("#create-question-item-1") do
            fill_in 'question_item[question_item_content]',	with: words_over_fifty
            fill_in 'question_item[question_item_answer]',  with: question_item_answer1
          end
        end
        it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
          expect(page).to have_content('1番目の質問は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
          expect(page).to have_button 'クエスチョンブロックを作成！', disabled: true
        end
      end

      context '1番目の答えが未入力の時' do
        before do
          fill_in 'question_block_title', with:  question_block_title
          within ("#create-question-item-1") do
            fill_in 'question_item[question_item_content]', with: question_item_content1
            fill_in 'question_item[question_item_answer]',  with:  ''
          end
        end
        it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
          expect(page).to have_content('1番目の答えを入力してね'), 'バリデーションメッセージが表示されていません'
          expect(page).to have_button 'クエスチョンブロックを作成！', disabled: true
        end
      end

      context '1番目の答えが51文字以上の時' do
        before do
          fill_in 'question_block_title', with:  question_block_title
          within ("#create-question-item-1") do
            fill_in 'question_item[question_item_content]',	with: question_item_content1
            fill_in 'question_item[question_item_answer]',  with: words_over_fifty
          end
        end
        it 'バリデーションメッセージが表示され、作成ボタンがdisabledであること' do
          expect(page).to have_content('1番目の答えは最大50文字だよ'), 'バリデーションメッセージが表示されていません'
          expect(page).to have_button 'クエスチョンブロックを作成！', disabled: true
        end
      end


      describe 'クエスチョンアイテム追加・削除機能' do
        describe 'アイテム追加機能' do
          context 'アイテムを追加した時' do
            before do
              expect(page).to have_selector('#create-question-item-1')
              expect(page).not_to have_selector('#create-question-item-2')
              expect(page).not_to have_selector('#create-question-item-3')
              find('#add-question-item-button').click
            end
            it '2つめのアイテム入力フォームが表示されること' do
              expect(page).to have_selector('#create-question-item-2')
            end

            it 'もう1度押すと3つめのアイテム入力フォームが表示されること' do
              find('#add-question-item-button').click
              expect(page).to have_selector('#create-question-item-3')
              expect(page).to have_button '質問と答えを追加する', disabled: true
            end
          end
        end

        describe 'アイテム削除機能' do
          context 'アイテムが2つある時' do
            before do
              find('#add-question-item-button').click
              expect(page).to have_selector('#create-question-item-2')
            end
            it 'アイテムを1つまで消すことができること' do
              find('#delete-question-item-button').click
              expect(page).not_to have_selector('#create-question-item-2')
            end
          end

          context 'アイテムが3つある時' do
            before do
              find('#add-question-item-button').click
              find('#add-question-item-button').click
              expect(page).to have_selector('#create-question-item-2')
              expect(page).to have_selector('#create-question-item-3')
            end
            it 'アイテムを2つまで消すことができること' do
              find('#delete-question-item-button').click
              expect(page).not_to have_selector('#create-question-item-3')
              find('#delete-question-item-button').click
              expect(page).not_to have_selector('#create-question-item-2')
            end
          end
        end

        describe 'アイテム数が3つ' do
          before do
            find('#add-question-item-button').click
            find('#add-question-item-button').click
            expect(page).to have_selector('#create-question-item-2')
            expect(page).to have_selector('#create-question-item-3')
          end
          context '全ての値を正常に入力した時' do
            before do
              fill_in 'question_block_title', with:  question_block_title
              within ("#create-question-item-1") do
                fill_in 'question_item[question_item_content]',	with: question_item_content1
                fill_in 'question_item[question_item_answer]',  with: question_item_answer1
              end
              within ("#create-question-item-2") do
                fill_in 'question_item[question_item_content]',	with: question_item_content2
                fill_in 'question_item[question_item_answer]',  with: question_item_answer2
              end
              within ("#create-question-item-3") do
                fill_in 'question_item[question_item_content]',	with: question_item_content3
                fill_in 'question_item[question_item_answer]',  with: question_item_answer3
              end
              expect(page).to have_button 'クエスチョンブロックを作成！', disabled: false
              click_on 'クエスチョンブロックを作成！'
            end
            it 'アイテム数が3つのクエスチョンブロックが作成されること' do
              expect(page).to have_content(question_block_title),   'クエスチョンブロックが作成されていません'
              expect(last_question_block.question_items.count).to eq(3), 'クエスチョンブロックのアイテム数が合っていません'
              expect(page).to have_content('クエスチョンブロックを作成したよ！'), 'フラッシュメッセージが表示されていません'
            end
          end

          context '全ての値が空値で入力された時' do
            before do
              fill_in 'question_block_title', with:  ''
              within ("#create-question-item-1") do
                fill_in 'question_item[question_item_content]',	with: ''
                fill_in 'question_item[question_item_answer]',  with: ''
              end
              within ("#create-question-item-2") do
                fill_in 'question_item[question_item_content]',	with: ''
                fill_in 'question_item[question_item_answer]',  with: ''
              end
              within ("#create-question-item-3") do
                fill_in 'question_item[question_item_content]',	with: ''
                fill_in 'question_item[question_item_answer]',  with: ''
              end
            end
            it "それぞれの空値のバリデーションメッセージが表示されること" do
              expect(page).to have_content(' タイトルを入力してね'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('1番目の質問を入力してね'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('1番目の答えを入力してね'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('2番目の質問を入力してね'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('2番目の答えを入力してね'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('3番目の質問を入力してね'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('3番目の答えを入力してね'), 'バリデーションメッセージが表示されていません'
            end
          end

          context '全ての値が50文字以上でで入力された時' do
            before do
              fill_in 'question_block_title', with:  words_over_fifty
              within ("#create-question-item-1") do
                fill_in 'question_item[question_item_content]',	with: words_over_fifty
                fill_in 'question_item[question_item_answer]',  with: words_over_fifty
              end
              within ("#create-question-item-2") do
                fill_in 'question_item[question_item_content]',	with: words_over_fifty
                fill_in 'question_item[question_item_answer]',  with: words_over_fifty
              end
              within ("#create-question-item-3") do
                fill_in 'question_item[question_item_content]',	with: words_over_fifty
                fill_in 'question_item[question_item_answer]',  with: words_over_fifty
              end
            end
            it "それぞれの空値のバリデーションメッセージが表示されること" do
              expect(page).to have_content('タイトルは最大50文字だよ'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('1番目の質問は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('1番目の答えは最大50文字だよ'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('2番目の質問は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('2番目の答えは最大50文字だよ'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('3番目の質問は最大50文字だよ'), 'バリデーションメッセージが表示されていません'
              expect(page).to have_content('3番目の答えは最大50文字だよ'), 'バリデーションメッセージが表示されていません'
            end
          end
        end
      end
    end
  end

  describe 'クエスチョンブロック編集機能' do
    before do
      click_on 'クエスチョンブロックを追加する'
      sleep 1
      find('#open-create-original-question-format-dialog').click
      fill_in 'question_block_title', with:  question_block_title
      within ("#create-question-item-1") do
        fill_in 'question_item[question_item_content]', with: question_item_content1
        fill_in 'question_item[question_item_answer]',  with:  question_item_answer1
      end
      click_on 'クエスチョンブロックを作成！'
      find("#edit-question-block-button-#{last_question_block.id}").click
      expect(page).to have_content('クエスチョンブロックを編集'), 'クエスチョンブロック編集モーダルが表示されていません'
      expect(page).to have_content(question_block_title), '作成したクエスチョンブロックのタイトルが表示されていません'
      expect(page).to have_content(question_item_content1), '作成したクエスチョンブロックの質問が表示されていません'
      expect(page).to have_content(question_item_answer1), '作成したクエスチョンブロックの答えが表示されていません'
    end
    describe '編集機能' do
      context 'タイトルを正常に編集した時' do
        before do
          find("#edit-question-block-title-button-#{last_question_block.id}").click
          expect(page).to have_selector("#edit-question-title-form-#{last_question_block.id}"), 'タイトル編集フォームがが表示されていません'
          fill_in "edit-question-title-form-#{last_question_block.id}", with:  edit_question_block_title
          find("#update-question-item-button-#{last_question_block.id}").click
        end
        it 'タイトルが更新されること' do
          expect(page).to have_content(edit_question_block_title), '更新したクエスチョンブロックのタイトルが表示されていません'
          expect(QuestionBlock.last.title).to eq(edit_question_block_title), 'タイトルが更新されていません' # DB上でも更新されているか確認
          expect(page).not_to have_selector("#edit-question-title-form-#{last_question_block.id}"), 'タイトル編集フォームがが表示されていません'
          expect(page).to have_content('クエスチョンブロックのタイトルを更新したよ！'), 'フラッシュメッセージが表示されていません'
        end
      end

      context 'タイトルを入力して更新ボタンを押さずに編集をキャンセルした時' do
        before do
          find("#edit-question-block-title-button-#{last_question_block.id}").click
          fill_in "edit-question-title-form-#{last_question_block.id}", with:  edit_question_block_title
          find("#cancel-question-item-update-button-#{last_question_block.id}").click
        end
        it '編集前のタイトルが表示されていること' do
          expect(page).to have_content(question_block_title), '編集前のタイトルが表示されていません'
        end
      end

      context 'アイテムの質問と答えを正常に編集した時' do
        before do
          find("#edit-question-item-button-#{question_item_1.id}").click
          expect(page).to have_selector("#edit-question-item-1"), 'アイテム編集フォームがが表示されていません'
          within ("#edit-question-item-1") do
            fill_in 'question_item[question_item_content]', with: edit_question_item_content1
            fill_in 'question_item[question_item_answer]',  with:  edit_question_item_answer1
          end
          find("#update-question-item-button-#{question_item_1.id}").click
        end
        it 'アイテムが更新されること' do
          expect(page).to have_content(edit_question_item_content1), '更新したクエスチョンブロックのアイテムの質問が表示されていません'
          expect(page).to have_content(edit_question_item_answer1), '更新したクエスチョンブロックのアイテムの答えが表示されていません'
          expect(QuestionBlock.last.question_items[0].content).to eq(edit_question_item_content1), 'アイテムが更新されていません' # DB上でも更新されているか確認
          expect(page).to have_content('クエスチョンアイテムを更新したよ！'), 'フラッシュメッセージが表示されていません'
        end
      end

      context 'アイテムを編集して更新ボタンを押さずにキャンセルした時' do
        before do
          find("#edit-question-item-button-#{question_item_1.id}").click
          within ("#edit-question-item-1") do
            fill_in 'question_item[question_item_content]', with: edit_question_item_content1
            fill_in 'question_item[question_item_answer]',  with:  edit_question_item_answer1
          end
          find("#cancel-question-item-update-button-'#{question_item_1.id}").click
        end
        fit '編集前のアイテムが表示されていること' do
          expect(page).to have_content(question_item_content1), '編集前のアイテムが表示されていません'
          expect(page).to have_content(question_item_answer1), '編集前のアイテムが表示されていません'
        end
      end
    end

    describe '作成機能' do
      context '正常に値を入力した場合' do
        before do
          expect(page).to have_button '作成', disabled: true
          expect(page).to have_selector('#individual-create-question-block-item-form'), 'アイテム作成フォームが表示されていません'
          within ("#individual-create-question-block-item-form") do
            fill_in 'question_item[question_item_content]', with: question_item_content2
            fill_in 'question_item[question_item_answer]',  with:  question_item_answer2
          end
          expect(page).to have_button '作成', disabled: false
          click_on '作成'
        end
        it '新しいアイテムが作成されること' do
          expect(page).to have_button '作成', disabled: true
          expect(page).to have_content(question_item_content2), '2番目のアイテムの質問が作成されていません'
          expect(page).to have_content(question_item_answer2), '2番目のアイテムの回答が作成されていません'
        end
      end
      context '2つ作成した場合' do
        before do
          expect(page).to have_button '作成', disabled: true
          expect(page).to have_selector('#individual-create-question-block-item-form'), 'アイテム作成フォームが表示されていません'
          within ("#individual-create-question-block-item-form") do
            fill_in 'question_item[question_item_content]', with: question_item_content2
            fill_in 'question_item[question_item_answer]',  with:  question_item_answer2
          end
          expect(page).to have_button '作成', disabled: false
          click_on '作成'
          expect(page).to have_button '作成', disabled: true
          expect(page).to have_selector('#individual-create-question-block-item-form'), 'アイテム作成フォームが表示されていません'
          within ("#individual-create-question-block-item-form") do
            fill_in 'question_item[question_item_content]', with: question_item_content3
            fill_in 'question_item[question_item_answer]',  with:  question_item_answer3
          end
          expect(page).to have_button '作成', disabled: false
          click_on '作成'
        end
        it '新規作成フォームの表示が消えること' do
          expect(page).not_to have_selector('#individual-create-question-block-item-form'), 'アイテム作成フォームが表示されています'
        end
      end
    end

    describe '削除機能' do
      before do
        expect(page).to have_button '作成', disabled: true
        expect(page).to have_selector('#individual-create-question-block-item-form'), 'アイテム作成フォームが表示されていません'
        within ("#individual-create-question-block-item-form") do
          fill_in 'question_item[question_item_content]', with: question_item_content2
          fill_in 'question_item[question_item_answer]',  with:  question_item_answer2
        end
        expect(page).to have_button '作成', disabled: false
        click_on '作成'
        expect(page).to have_content(question_item_content2), '2番目のアイテムの質問が作成されていません'
        expect(page).to have_content(question_item_answer2), '2番目のアイテムの回答が作成されていません'
      end
      context '一つのアイテムを削除した場合' do
        before do
          within ("#edit-question-item-2") do
            expect(page).to have_selector("#delete-question-item-button-#{question_item_2.id}")
            find("#delete-question-item-button-#{question_item_2.id}").click
            page.driver.browser.switch_to.alert.accept
          end
        end
        it 'アイテムが1つ消えること' do
          expect(page).not_to have_content(question_item_content2), '2番目のアイテムの質問が表示されています'
          expect(page).not_to have_content(question_item_answer2), '2番目のアイテムの回答が表示されています'
        end
      end
      context 'アイテムが3つある状態で1つアイテムを削除する場合' do
        before do
          expect(page).to have_button '作成', disabled: true
          expect(page).to have_selector('#individual-create-question-block-item-form'), 'アイテム作成フォームが表示されていません'
          within ("#individual-create-question-block-item-form") do
            fill_in 'question_item[question_item_content]', with: question_item_content2
            fill_in 'question_item[question_item_answer]',  with:  question_item_answer2
          end
          expect(page).to have_button '作成', disabled: false
          click_on '作成'
          expect(page).to have_button '作成', disabled: true
          expect(page).to have_selector('#individual-create-question-block-item-form'), 'アイテム作成フォームが表示されていません'
          within ("#individual-create-question-block-item-form") do
            fill_in 'question_item[question_item_content]', with: question_item_content3
            fill_in 'question_item[question_item_answer]',  with:  question_item_answer3
          end
          expect(page).to have_button '作成', disabled: false
          click_on '作成'
          expect(QuestionBlock.last.question_items.count).to eq(3)
          expect(page).not_to have_selector('#individual-create-question-block-item-form'), 'アイテム作成フォームが表示されています'

          within ("#edit-question-item-3") do
            expect(page).to have_selector("#delete-question-item-button-#{question_item_3.id}")
            find("#delete-question-item-button-#{question_item_3.id}").click
            page.driver.browser.switch_to.alert.accept
          end
        end
        it '新規作成フォームが表示されること' do
          expect(page).to have_selector('#individual-create-question-block-item-form'), 'アイテム作成フォームが表示されています'
        end
      end
    end
  end

  describe 'クエスチョンブロック削除機能' do
    before do
      click_on 'クエスチョンブロックを追加する'
      sleep 1
      find('#open-create-original-question-format-dialog').click
      fill_in 'question_block_title', with:  question_block_title
      within ("#create-question-item-1") do
        fill_in 'question_item[question_item_content]', with: question_item_content1
        fill_in 'question_item[question_item_answer]',  with:  question_item_answer1
      end
      click_on 'クエスチョンブロックを作成！'
    end
    context '削除ボタンを押してconfirmダイアログで「OK」を選択した時' do
      before do
        find("#delete-question-block-button-#{last_question_block.id}").click
        page.driver.browser.switch_to.alert.accept # confirmダイアログで「OK」を選択する
      end
      it '対象のクエスチョンブロックが削除されること' do
        expect(page).not_to have_content(question_block_title), '対象のクエスチョンブロックが削除されていません'
        expect(page).to have_content('クエスチョンブロックを削除したよ！'), 'フラッシュメッセージが表示されていません'
      end
    end

    context '削除ボタンを押してconfirmダイアログで「キャンセル」を選択した時' do
      before do
        find("#delete-question-block-button-#{last_question_block.id}").click
        page.driver.browser.switch_to.alert.dismiss # confirmダイアログで「キャンセル」を選択する
      end
      it '対象のクエスチョンブロックが削除されないこと' do
        expect(page).to have_content(question_block_title), '対象のクエスチョンブロックが削除されています'
        expect(page).not_to have_content('クエスチョンブロックを削除したよ！'), 'フラッシュメッセージが表示されています'
      end
    end
  end
end
