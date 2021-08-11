# frozen_string_literal: true

module LoginModule
  def login(user)
    visit new_user_session_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end
end
