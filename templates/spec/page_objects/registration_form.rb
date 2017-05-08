module PageObjects
  class RegistrationForm < Base
    def fill_and_submit_with(user_info)
      self.email = user_info.email
      self.password = user_info.password
      submit
    end

    def email=(email)
      fill_in "Email", with: email
    end

    def password=(password)
      fill_in "Password", with: password
      fill_in "Password confirmation", with: password
    end

    def submit
      click_on "Sign up"
    end

    def selector
      '.registrations.new form#new_user'
    end
  end
end
