require 'rails_helper'
require 'support/login_support'

RSpec.feature "Header", type: :feature do
  given(:user) { build(:user) }
  include LoginSupport

  background do
    visit root_path
  end

  describe "show header when logged in" do
    background do
      signup(user)
      logout
      signin(user)
    end

    scenario "user click logo" do
      click_link "musiQ"
      expect(current_path).to eq root_path
    end

    scenario "user click toggle" do
      within("div.header-menu") do
        expect(page).to have_content "作ってあそぶ"
        expect(page).to have_content "答えてあそぶ"
        expect(page).to have_content "ログアウト"
        expect(page).not_to have_content "ログイン"
        expect(page).not_to have_content "新規登録"
      end
    end
  end

  describe "show header when not logged in" do
    scenario "user click logo" do
      click_link "musiQ"
      expect(current_path).to eq root_path
    end

    scenario "user click toggle" do
      within("div.header-menu") do
        expect(page).to have_content "答えてあそぶ"
        expect(page).to have_content "ログイン"
        expect(page).to have_content "新規登録"
        expect(page).not_to have_content "ログアウト"
        expect(page).not_to have_content "作ってあそぶ"
      end
    end
  end
end
