# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'アカウント編集' do
    context '通常登録ユーザーの場合' do
      let(:alice) { create(:alice) }

      it 'すべてのフォームがあること' do
        login alice
        visit edit_user_registration_path

        expect(page).to have_css 'input#user_email'
        expect(page).to have_css 'input#user_password'
        expect(page).to have_css 'input#user_password_confirmation'
        expect(page).to have_css 'input#user_current_password'
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
        expect(page).to have_link 'アカウント削除', href: user_registration_path
      end
    end

    context 'Google認証で登録したユーザーの場合' do
      let(:google) { create(:google_oauth) }

      it 'メールアドレス入力フォーム、ログアウト・削除リンクのみがあること' do
        login google
        visit edit_user_registration_path

        expect(page).to have_css 'input#user_email'
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
        expect(page).to have_link 'アカウント削除', href: user_registration_path
        expect(page).not_to have_css 'input#user_password'
        expect(page).not_to have_css 'input#user_password_confirmation'
        expect(page).not_to have_css 'input#user_current_password'
      end
    end
  end
end