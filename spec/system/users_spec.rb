# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe '新規登録画面' do
    it 'Eメール、パスワード、パスワード確認入力フォームとGoogleログインボタンが表示されること' do
      visit new_user_registration_path
      expect(page).to have_css 'input#user_email'
      expect(page).to have_css 'input#user_password'
      expect(page).to have_css 'input#user_password_confirmation'
      expect(page).to have_selector "img[src$='g-logo.png']"
      expect(page).to have_content 'Googleアカウントで登録'
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
      expect(page).to have_selector "img[src$='g-logo.png']"
      expect(page).to have_content 'Googleアカウントでログイン'
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

  describe 'パスワードリマインダー' do
    def generate_reset_password_url
      mail = ActionMailer::Base.deliveries.last
      body = mail.body.encoded.split(/\r\n/).map { |i| Base64.decode64(i) }.join
      body[%r{/users/password/edit?[^"]+=\w+}]
    end

    it 'Eメール入力フォームとボタンが表示されていること' do
      visit new_user_password_path
      expect(page).to have_content 'パスワード再設定'
      expect(page).to have_css 'input#user_email'
      expect(page).to have_button 'パスワード再設定方法を送信'
    end

    context '正しいメールアドレスの場合' do
      it 'メールが送信され、パスワード変更画面でパスワードを変更できること' do
        user = create(:alice)
        visit new_user_password_path
        fill_in 'Eメール', with: user.email

        # メールが送信されていることを確認
        expect { click_button 'パスワード再設定方法を送信' }.to change { ActionMailer::Base.deliveries.size }.by(1)
        expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'

        url = generate_reset_password_url
        visit url

        # 要素があることを確認
        expect(page).to have_content 'パスワードを変更'
        expect(page).to have_css 'input#user_password'
        expect(page).to have_css 'input#user_password_confirmation'
        expect(page).to have_button 'パスワードを変更する'

        # 空で送信すると失敗することを確認
        click_button 'パスワードを変更する'
        expect(page).to have_content 'パスワードを入力してください'

        # 一致しないと失敗することを確認
        fill_in '新しいパスワード', with: 'testtest'
        fill_in '確認用新しいパスワード', with: 'testtesttest'
        click_button 'パスワードを変更する'
        expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'

        # パスワード更新ができることを確認
        fill_in '新しいパスワード', with: 'testtest'
        fill_in '確認用新しいパスワード', with: 'testtest'
        click_button 'パスワードを変更する'
        expect(page).to have_content 'パスワードが正しく変更されました。'
      end
    end

    context 'メールアドレスが間違っている場合' do
      it '「Eメールは見つかりませんでした。」と表示されること' do
        visit new_user_password_path
        fill_in 'Eメール', with: 'test@example.com'
        expect { click_button 'パスワード再設定方法を送信' }.not_to(change { ActionMailer::Base.deliveries.size })
        expect(page).to have_content 'Eメールは見つかりませんでした。'
      end
    end

    context '間違いがある場合' do
      context '再設定用URLに間違いがある場合' do
        it '「このページにはアクセスできません。パスワード再設定メールのリンクからアクセスされた場合には、URL をご確認ください。」と表示されること' do
          user = create(:alice)
          visit new_user_password_path
          fill_in 'Eメール', with: user.email
          click_button 'パスワード再設定方法を送信'

          visit edit_user_password_path
          expect(page).to have_content 'このページにはアクセスできません。パスワード再設定メールのリンクからアクセスされた場合には、URL をご確認ください。'
        end
      end

      context 'tokenが期限切れの場合' do
        it '「パスワードリセット用トークンの有効期限が切れました。新しくリクエストしてください。」と表示されること' do
          user = create(:alice)
          visit new_user_password_path
          fill_in 'Eメール', with: user.email
          click_button 'パスワード再設定方法を送信'

          url = generate_reset_password_url
          visit url

          travel_to 1.days.from_now do
            fill_in '新しいパスワード', with: 'testtest'
            fill_in '確認用新しいパスワード', with: 'testtest'
            click_button 'パスワードを変更する'
            expect(page).to have_content 'パスワードリセット用トークンの有効期限が切れました。新しくリクエストしてください。'
          end
        end
      end
    end
  end

  describe 'アカウント確認メール再送' do
    let(:email) { 'test@example.com' }

    before do
      # 前処理 - ユーザー登録
      visit new_user_registration_path
      fill_in 'Eメール', with: email
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button 'アカウント登録'

      visit new_user_confirmation_path
    end

    it '要素が表示され、メールが再送されること' do
      # 要素が表示されていること
      expect(page).to have_css 'input#user_email'
      expect(page).to have_button 'アカウント確認メール再送'

      fill_in 'Eメール', with: email

      # メールが送信されていること
      expect { click_button 'アカウント確認メール再送' }.to change { ActionMailer::Base.deliveries.size }.by(1)
      # 送信メッセージが表示されること
      expect(page).to have_content 'アカウントの有効化について数分以内にメールでご連絡します。'
    end

    context 'メールアドレスが未入力の場合' do
      it 'メールが送信されず、「Eメールを入力してください」と表示されること' do
        expect { click_button 'アカウント確認メール再送' }.not_to(change { ActionMailer::Base.deliveries.size })
        expect(page).to have_content 'Eメールを入力してください'
      end
    end

    context 'メールアドレスが見つからない場合' do
      it 'メールが送信されず、「Eメールは見つかりませんでした。」と表示されること' do
        fill_in 'Eメール', with: 'testtest@example.com'

        expect { click_button 'アカウント確認メール再送' }.not_to(change { ActionMailer::Base.deliveries.size })
        expect(page).to have_content 'Eメールは見つかりませんでした。'
      end
    end
  end

  describe 'アカウント編集' do
    before do
      login user
      visit edit_user_registration_path
    end

    context '通常登録ユーザーの場合' do
      let(:user) { create(:alice) }

      it 'すべてのフォームがあること' do
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

      it 'パスワードなしで割引率を更新できること' do
        choose '20％以上安ければ通知する'
        click_button '更新'
        expect(page).to have_content 'アカウント情報を変更しました。'

        visit edit_user_registration_path
        expect(page).to have_checked_field '20％以上安ければ通知する'
      end

      it 'パスワードなしでEメールを更新できること' do
        fill_in 'Eメール', with: 'testtest@example.com'
        expect { click_button '更新' }.to change { ActionMailer::Base.deliveries.size }.by(1)
        expect(page).to have_content 'アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。'

        token = User.find(user.id).confirmation_token
        visit user_confirmation_path(confirmation_token: token)
        expect(page).to have_content 'メールアドレスが確認できました。'

        visit edit_user_registration_path
        expect(page).to have_field 'Eメール', with: 'testtest@example.com'
      end

      it 'パスワードを更新できること' do
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認用）', with: 'password'
        fill_in '現在のパスワード', with: user.password
        click_button '更新'
        expect(page).to have_content 'アカウント情報を変更しました。'
      end

      it 'ログアウトできること' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
      end

      it 'アカウントを削除できること' do
        page.accept_confirm do
          click_link 'アカウント削除'
        end
        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      end

      context '入力に不備がある場合' do
        context 'メールアドレスが登録済みの場合' do
          it 'Eメールはすでに存在しますと表示されること' do
            other_user = create(:rating_even)
            fill_in 'Eメール', with: other_user.email
            click_button '更新'
            expect(page).to have_content 'Eメールはすでに存在します'
          end
        end

        context 'パスワードとパスワード(確認用)が一致しない場合' do
          it '「パスワード（確認用）とパスワードの入力が一致しません」と表示されること' do
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード（確認用）', with: 'passworddd'
            fill_in '現在のパスワード', with: user.password
            click_button '更新'
            expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
          end
        end

        context 'パスワード（確認用）が未入力の場合' do
          it '「パスワード（確認用）とパスワードの入力が一致しません」と表示されること' do
            fill_in 'パスワード', with: 'password'
            fill_in '現在のパスワード', with: user.password
            click_button '更新'
            expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
          end
        end

        context '現在のパスワードが未入力の場合' do
          it '「現在のパスワードを入力してください」と表示されること' do
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード（確認用）', with: 'password'
            click_button '更新'
            expect(page).to have_content '現在のパスワードを入力してください'
          end
        end

        context '現在のパスワードが間違っている場合' do
          it '「現在のパスワードは不正な値です」と表示されること' do
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード（確認用）', with: 'password'
            fill_in '現在のパスワード', with: 'testtest'
            click_button '更新'
            expect(page).to have_content '現在のパスワードは不正な値です'
          end
        end
      end
    end

    context 'Google認証で登録したユーザーの場合' do
      let(:user) { create(:google_oauth) }

      it 'メールアドレス入力フォーム、割引率設定、ログアウト・削除リンクのみがあること' do
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

      it 'パスワードなしで割引率を更新できること' do
        choose '20％以上安ければ通知する'
        click_button '更新'
        expect(page).to have_content 'アカウント情報を変更しました。'

        visit edit_user_registration_path
        expect(page).to have_checked_field '20％以上安ければ通知する'
      end

      it 'パスワードなしでEメールを更新できること' do
        fill_in 'Eメール', with: 'testtest@example.com'
        expect { click_button '更新' }.to change { ActionMailer::Base.deliveries.size }.by(1)
        expect(page).to have_content 'アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。'

        token = User.find(user.id).confirmation_token
        visit user_confirmation_path(confirmation_token: token)
        expect(page).to have_content 'メールアドレスが確認できました。'

        visit edit_user_registration_path
        expect(page).to have_field 'Eメール', with: 'testtest@example.com'
      end

      it 'ログアウトできること' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
      end

      it 'アカウントを削除できること' do
        page.accept_confirm do
          click_link 'アカウント削除'
        end
        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      end
    end
  end
end
