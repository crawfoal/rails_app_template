module PageObjects
  class SignInForm < Base
    def fill_and_submit_for(user)
      self.email = user.email
      self.password = user.password
      submit
    end

    def email=(email)
      fill_in 'Email', with: email
    end

    def password=(password)
      fill_in 'Password', with: password
    end

    def submit
      click_on 'Log in'
    end

    def selector
      '.sessions.new form#new_user'
    end
  end
end
