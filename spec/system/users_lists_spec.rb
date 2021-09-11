# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/lists', type: :system do
  describe '#create' do
    context 'ログイン状態で通知を受け取るボタンを押した場合' do
      it '登録に成功してボタンが非活性になっている' do
        visit_with_auth root_path, :alice
        fill_in '検索ワード or ISBN', with: '9784774193977'
        click_button '検索する'
        click_button 'セール通知を受け取る'
        expect(page).to have_content 'リストに追加しました！'
        expect(page).to have_button 'リスト登録済み', disabled: true
      end
    end
  end

  describe '#show' do
    context '未ログイン状態でアクセスした場合' do
      it 'フラッシュメッセージが表示される' do
        visit 'users/lists/3'
        expect(page).to have_content 'ログインもしくはアカウント登録してください。'
      end
    end

    context '自分のリストにアクセスした場合' do
      it 'アクセスできる' do
        list = create(:list)
        login(list.user)
        visit users_list_path list.id
        expect(page).to have_selector 'h2', text: 'セール通知リスト'
      end

      it '登録した書籍が表示される' do
        list_detail = create(:list_detail_one)
        login(list_detail.list.user)
        visit users_list_path list_detail.list.id
        expect(page).to have_content 'プロを目指す人のためのRuby入門'
      end

      it '削除ボタンが表示される' do
        list_detail = create(:list_detail_one)
        login(list_detail.list.user)
        visit users_list_path list_detail.list.id
        expect(page).to have_selector 'a.button.is-danger', text: '削除する'
      end
    end

    context '自分のリスト以外にアクセスした場合' do
      it 'rootにリダイレクトしてフラッシュメッセージが表示される' do
        list = create(:list)
        login(list.user)
        visit users_list_path list.id + 1
        expect(page).to have_content 'URLが不正です。'
      end
    end
  end
end
