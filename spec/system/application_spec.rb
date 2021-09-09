# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'application', type: :system do
  describe 'header menu' do
    context 'ログインしていない場合' do
      before do
        visit root_path
      end

      it 'ロゴ画像が表示される' do
        expect(page).to have_selector "img[src$='logo.png']"
      end

      it 'ナビゲーションメニューが表示されない' do
        expect(page).not_to have_selector '.navbar_item'
      end
    end

    context 'ログインしてリスト作成済みの場合' do
      before do
        list = create(:list)
        login(list.user)
        visit root_path
      end

      it 'ロゴ画像が表示される' do
        expect(page).to have_selector "img[src$='logo.png']"
      end

      it 'ユーザーアイコンが表示される' do
        expect(page).to have_selector '.material-icons.md-36', text: 'manage_accounts'
      end

      it 'リストアイコンが表示される' do
        expect(page).to have_selector '.material-icons.md-36', text: 'receipt_long'
      end
    end

    context 'ログインしてリスト未作成の場合' do
      before do
        visit_with_auth root_path, :alice
      end

      it 'ロゴ画像が表示される' do
        expect(page).to have_selector "img[src$='logo.png']"
      end

      it 'ユーザーアイコンが表示される' do
        expect(page).to have_selector '.material-icons.md-36', text: 'manage_accounts'
      end

      it 'リストアイコンが表示されない' do
        expect(page).not_to have_selector '.material-icons.md-36', text: 'receipt_long'
      end
    end
  end
end
