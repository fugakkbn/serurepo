# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home', type: :system do
  describe '#index' do
    context 'ログインせずに/にアクセスした場合' do
      it 'welcome#indexを表示' do
        visit root_path
        expect(page).to have_selector 'h2', text: "「いつか読みたい本」\n安い時に買いませんか？"
      end

      it '利用規約とプライバシーポリシーのリンクが表示されること' do
        visit root_path
        expect(page).to have_link '利用規約', href: tos_path
        expect(page).to have_link 'プライバシーポリシー', href: privacy_policy_path
      end
    end

    context 'ログインして/にアクセスした場合' do
      before do
        visit_with_auth '/', :alice
      end

      it 'home#indexを表示' do
        expect(page).to have_selector 'h2', text: '書籍検索'
      end

      it '利用規約とプライバシーポリシーのリンクが表示されること' do
        expect(page).to have_link '利用規約', href: tos_path
        expect(page).to have_link 'プライバシーポリシー', href: privacy_policy_path
      end
    end
  end
end
