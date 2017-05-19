require 'rails_helper'

RSpec.describe 'Flash messages' do
  scenario 'Anyone triggers flash message to appear, and then dimisses it',
           :js do
    visit new_user_session_path

    sign_in_form.submit
    flash.dismiss

    expect(page).to_not show :flash
  end
end
