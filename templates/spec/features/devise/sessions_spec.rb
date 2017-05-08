require 'rails_helper'

RSpec.describe "User Sessions", type: :feature do
  scenario "User signs in from sign in page" do
    user = create :user

    visit new_user_session_path
    sign_in_form.fill_and_submit_for user

    expect(page).to flash_message t('devise.sessions.signed_in')
    expect(page).to show :welcome_page
  end

  scenario "User signs out from welcome page" do
    create_and_login_user

    visit welcome_index_path
    appbar.open_drawer
    nav_drawer.sign_out

    expect(page).to flash_message t('devise.sessions.signed_out')
    expect(page).to show :welcome_page
  end
end
