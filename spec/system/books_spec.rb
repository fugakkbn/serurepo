# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books', type: :system do
  describe '#index' do
    context '未ログインでアクセスした場合' do
      it 'ログインを促すメッセージが表示される' do
        visit 'books/?query=ruby'
        expect(page).to have_content 'ログインもしくはアカウント登録してください。'
      end
    end

    context 'ISBNで検索した場合' do
      it 'プロを目指す人のためのRuby入門が表示される' do
        visit_with_auth root_path, :alice
        fill_in '検索ワード or ISBN', with: '9784774193977'
        click_button '検索する'
        expect(page).to have_selector '#book-title', text: 'プロを目指す人のためのRuby入門'
      end
    end

    context 'ワード検索した場合' do
      it '.mediaが2つ以上ある' do
        visit_with_auth root_path, :alice
        fill_in '検索ワード or ISBN', with: 'ruby'
        click_button '検索する'
        media = all('.block .media')
        expect(media.size).to be >= 2
      end
    end

    context '検索結果がなかった場合' do
      it '該当する書籍がありませんでしたと表示される' do
        visit_with_auth root_path, :alice
        fill_in '検索ワード or ISBN', with: '123456789'
        click_button '検索する'
        expect(page).to have_content '該当する書籍がありませんでした。'
      end
    end

    context '空で検索した場合' do
      it '検索ワードを入力してください。と表示される' do
        visit_with_auth root_path, :alice
        click_button '検索する'
        expect(page).to have_content '検索ワードを入力してください。'
      end
    end

    context '100ページより多いページ数が指定された場合' do
      it 'パラメーターが不正です。と表示される' do
        visit_with_auth '/books?page=101&query=ruby', :alice
        expect(page).to have_content 'パラメーターが不正です。'
      end
    end

    context 'ページ数に負の数値が指定された場合' do
      it 'パラメーターが不正です。と表示される' do
        visit_with_auth '/books?page=-1&query=ruby', :alice
        expect(page).to have_content 'パラメーターが不正です。'
      end
    end

    context 'ページ数に数値以外が指定された場合' do
      it 'パラメーターが不正です。と表示される' do
        visit_with_auth '/books?page=aaa&query=ruby', :alice
        expect(page).to have_content 'パラメーターが不正です。'
      end
    end

    context 'ISBNが1桁多い場合' do
      it '該当する書籍がありませんでした。と表示される' do
        visit_with_auth root_path, :alice
        fill_in '検索ワード or ISBN', with: '97847741939771'
        click_button '検索する'
        expect(page).to have_content '該当する書籍がありませんでした。'
      end
    end

    context 'ISBNが1桁少ない場合' do
      it '該当する書籍がありませんでした。と表示される' do
        visit_with_auth root_path, :alice
        fill_in '検索ワード or ISBN', with: '978477419397'
        click_button '検索する'
        expect(page).to have_content '該当する書籍がありませんでした。'
      end
    end
  end
end
