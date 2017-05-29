gem 'spring-commands-rspec', group: :test
gem 'faker', group: [:development, :test]
gem 'pry'
gem 'rspec-rails', '~> 3.5', group: [:development, :test]
gem 'capybara', group: [:development, :test]
require 'mkmf'
unless find_executable('phantomjs')
    if find_executable('brew')
      run 'brew install phantomjs'
      run 'rm mkmf.log'
    else
      say snippet('missing_phantom_js_message.txt')
    end
end
gem 'poltergeist', group: :test
gem 'factory_girl_rails', group: [:development, :test]
gem 'database_cleaner', group: :test
gem 'shoulda-matchers', group: :test
gem 'webmock', group: :test
gem 'rails-controller-testing', group: :test
gem 'guard-rspec', require: false, group: :development
gem 'devise'
gem 'decent_exposure'
gem 'haml-rails'
gem 'font-awesome-rails'
gem 'record_tag_helper'
gem 'bourbon'
gem 'bitters'
gem 'jquery-ui-rails'
