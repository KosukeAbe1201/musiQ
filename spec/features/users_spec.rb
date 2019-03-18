require 'rails_helper'
require 'support/login_support'

RSpec.feature "Users", type: :feature do
  given(:user) { build(:user) }
  include LoginSupport

  scenario "user can signup and logout, but cannot signup with a name already taken" do
    signup(user)
    expect(page).to have_content "登録を完了しました"
    logout
    expect(current_path).to eq root_path
    signup(user)
    expect(page).to have_content "名前が既に使用されている、またはパスワードに不備があります"
  end

  scenario "user can login with available account" do
    signup(user)
    logout
    signin(user)
    expect(page).to have_content "ログインしました"
  end

  scenario "user can not login with mistaken account" do
    signup(user)
    logout
    click_link "ログイン"
    fill_in "name", with: user.password
    fill_in "password", with: user.name
    click_button "ログイン"
    expect(page).to have_content "メールアドレスまたはパスワードが間違っています"
  end
end
