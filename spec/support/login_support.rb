module LoginSupport
  def signup(user)
    visit root_path
    click_link "新規登録"
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "登録"
  end

  def signin(user)
    click_link "ログイン"
    fill_in "name", with: user.name
    fill_in "password", with: user.password
    click_button "ログイン"
  end

  def logout
    click_link "ログアウト"
  end
end
