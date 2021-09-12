# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcomes', type: :system do
  describe '#tos' do
    context '未ログインの場合' do
      it '利用規約ページが表示されること' do
        visit tos_path
        expect(page).to have_selector 'h2', text: '利用規約'
      end
    end

    context 'ログイン状態の場合' do
      it '利用規約ページが表示されること' do
        visit_with_auth '/tos', :alice
        expect(page).to have_selector 'h2', text: '利用規約'
      end
    end
  end

  describe '#privacy_policy' do
    context '未ログインの場合' do
      it '利用規約ページが表示されること' do
        visit privacy_policy_path
        expect(page).to have_selector 'h2', text: 'プライバシーポリシー'
      end
    end

    context 'ログイン状態の場合' do
      it '利用規約ページが表示されること' do
        visit_with_auth '/privacy_policy', :alice
        expect(page).to have_selector 'h2', text: 'プライバシーポリシー'
      end
    end
  end
end
