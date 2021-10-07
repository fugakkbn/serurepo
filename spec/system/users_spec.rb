# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe '新規登録画面' do
    it 'Eメール、パスワード、パスワード確認入力フォームとGoogleログインボタンが表示されること' do
      visit new_user_registration_path
      expect(page).to have_css 'input#user_email'
      expect(page).to have_css 'input#user_password'
      expect(page).to have_css 'input#user_password_confirmation'
      expect(page).to have_selector "img[src$='google_oauth2_sign_in.png']"
    end

    context '全てのフォームが入力されている場合' do
      context '正しい入力値の場合' do
        it '登録され、アカウント有効化を促すメッセージが表示されること' do
          visit new_user_registration_path
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button 'アカウント登録'
          expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
        end
      end

      context '重複するメールアドレスの場合' do
        it '「Eメールはすでに存在します」と表示されること' do
          user = create(:alice)
          visit new_user_registration_path
          fill_in 'Eメール', with: user.email
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button 'アカウント登録'
          expect(page).to have_content 'Eメールはすでに存在します'
        end
      end

      context 'パスワードと確認用パスワードが一致しない場合' do
        it '「パスワード（確認用）とパスワードの入力が一致しません」と表示されること' do
          visit new_user_registration_path
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'passpass'
          click_button 'アカウント登録'
          expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
        end
      end

      context 'パスワードが5文字の場合' do
        it '「パスワードは6文字以上で入力してください」と表示されること' do
          visit new_user_registration_path
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'passw'
          fill_in 'パスワード（確認用）', with: 'passw'
          click_button 'アカウント登録'
          expect(page).to have_content 'パスワードは6文字以上で入力してください'
        end
      end
    end

    context '未入力のフォームがある場合' do
      context 'メールアドレスが未入力の場合' do
        it '「Eメールを入力してください」と表示されること' do
          visit new_user_registration_path
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button 'アカウント登録'
          expect(page).to have_content 'Eメールを入力してください'
        end
      end

      context 'パスワードが未入力の場合' do
        it '「パスワードを入力してください」と表示されること' do
          visit new_user_registration_path
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button 'アカウント登録'
          expect(page).to have_content 'パスワードを入力してください'
        end
      end

      context '確認用パスワードが未入力の場合' do
        it '「パスワード（確認用）とパスワードの入力が一致しません」と表示されること' do
          visit new_user_registration_path
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'password'
          click_button 'アカウント登録'
          expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
        end
      end

      context 'パスワードと確認用パスワードが未入力の場合' do
        it '「パスワードを入力してください」と表示されること' do
          visit new_user_registration_path
          fill_in 'Eメール', with: 'test@example.com'
          click_button 'アカウント登録'
          expect(page).to have_content 'パスワードを入力してください'
        end
      end
    end
  end

  describe 'ログイン画面' do
    it 'Eメール、パスワード入力フォームとGoogleログインボタンが表示されること' do
      visit new_user_session_path
      expect(page).to have_css 'input#user_email'
      expect(page).to have_css 'input#user_password'
      expect(page).to have_selector "img[src$='google_oauth2_sign_in.png']"
    end

    context '全てのフォームが入力されている場合' do
      it '「ログインしました。」と表示されること' do
        user = create(:alice)
        visit new_user_session_path
        fill_in 'Eメール', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
      end
    end

    context '未入力のフォームがある場合' do
      context 'すべて未入力の場合' do
        it '「Eメールまたはパスワードが違います。」と表示されること' do
          visit new_user_session_path
          click_button 'ログイン'
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
        end
      end

      context 'メールアドレスが未入力の場合' do
        it '「Eメールまたはパスワードが違います。」と表示されること' do
          visit new_user_session_path
          fill_in 'パスワード', with: 'password'
          click_button 'ログイン'
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
        end
      end

      context 'パスワードが未入力の場合' do
        it '「Eメールまたはパスワードが違います。」と表示されること' do
          visit new_user_session_path
          fill_in 'Eメール', with: 'test@example.com'
          click_button 'ログイン'
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
        end
      end
    end

    context '入力に不備がある場合' do
      context 'メールアドレスが未登録の場合' do
        it '「Eメールまたはパスワードが違います。」と表示されること' do
          visit new_user_session_path
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログイン'
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
        end
      end

      context 'パスワードが間違っている場合' do
        it '「Eメールまたはパスワードが違います。」と表示されること' do
          user = create(:alice)
          visit new_user_session_path
          fill_in 'Eメール', with: user.email
          fill_in 'パスワード', with: 'testpass'
          click_button 'ログイン'
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
        end
      end
    end
  end

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
        expect(page).to have_css 'input#user_discount_rating_even'
        expect(page).to have_css 'input#user_discount_rating_over10'
        expect(page).to have_css 'input#user_discount_rating_over20'
        expect(page).to have_css 'input#user_discount_rating_over30'
        expect(page).to have_css 'input#user_discount_rating_over50'
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
        expect(page).to have_link 'アカウント削除', href: user_registration_path
      end
    end

    context 'Google認証で登録したユーザーの場合' do
      let(:google) { create(:google_oauth) }

      it 'メールアドレス入力フォーム、割引率設定、ログアウト・削除リンクのみがあること' do
        login google
        visit edit_user_registration_path

        expect(page).to have_css 'input#user_email'
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
        expect(page).to have_link 'アカウント削除', href: user_registration_path
        expect(page).to have_css 'input#user_discount_rating_even'
        expect(page).to have_css 'input#user_discount_rating_over10'
        expect(page).to have_css 'input#user_discount_rating_over20'
        expect(page).to have_css 'input#user_discount_rating_over30'
        expect(page).to have_css 'input#user_discount_rating_over50'
        expect(page).not_to have_css 'input#user_password'
        expect(page).not_to have_css 'input#user_password_confirmation'
        expect(page).not_to have_css 'input#user_current_password'
      end
    end
  end
end
