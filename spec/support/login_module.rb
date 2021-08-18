# frozen_string_literal: true

module LoginModule
  def login(user)
    visit new_user_session_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  def visit_with_auth(url, user)
    login_user = create(user)
    login(login_user)
    visit url
  end
end
