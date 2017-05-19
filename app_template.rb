def source_paths
  # Array(super) + [File.join(__dir__, 'templates')]
  # [File.join(__dir__, 'templates')]
  [File.join(__dir__, 'templates')] + Array(super)
end

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
      say "\nYou don't have PhantomJS installed, and it is a requirement for"\
           "Poltergeist (the JavaScript driver we've told Capybara to use). "\
           "Please see http://phantomjs.org/quick-start.html for installation "\
           "instructions.\n"
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

after_bundle do
  run 'bundle exec spring binstub rspec'

  application <<~RUBY
    config.generators do |g|
      \s\sg.stylesheets false
      \s\sg.javascripts false
      \s\sg.helper false
      \s\sg.view_specs false
      \s\send

    config.i18n.load_path +=
    \s\sDir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    \s\sconsole do
      \s\srequire 'pry'
      \s\sconfig.console = Pry
    \s\send
  RUBY

  environment "# Devise said to do this\n\s\s"\
    "config.action_mailer.default_url_options = "\
    "{ host: 'localhost', port: 3000 }\n",
    env: ['development', 'test']
  uncomment_lines 'config/environments/development.rb', /missing_translations/
  uncomment_lines 'config/environments/test.rb', /missing_translations/

  run 'spring stop' # the following command might hang if we don't stop spring
  generate 'rspec:install'

  uncomment_lines 'spec/rails_helper.rb', /.*spec\/support\/\*\*\/\*\.rb.*/
  gsub_file 'spec/rails_helper.rb',
    "config.use_transactional_fixtures = true",
    "config.use_transactional_fixtures = false"

  prepend_to_file 'spec/spec_helper.rb', <<~RUBY
    require 'webmock/rspec'
    WebMock.disable_net_connect!(:allow_localhost => true)\n
  RUBY

  directory 'spec/support'
  directory 'spec/page_objects'
  copy_file 'spec/support/configurations/page_objects.rb'

  run 'bundle exec guard init rspec'
  gsub_file 'Guardfile', /^guard.*.do.*$/, 'guard :rspec, cmd: "bin/rspec" do'

  generate 'devise:install'
  generate 'devise', 'user'

  rake 'haml:erb2haml'
  inside 'app/views/layouts' do
    insert_into_file 'application.html.haml',
      "\n\s\s\s\s%meta{charset: \"utf-8\"}/"\
      "\n\s\s\s\s%meta{:name => \"viewport\", :content => \"width=device-width, initial-scale=1\"}/",
      after: '%head'

    gsub_file 'application.html.haml',
      /^.*yield.*$/,
      "\s\s\s\s%main{:class => \"\#{controller_name} \#{action_name}\"}= yield"

    insert_into_file 'application.html.haml',
      "\n\s\s\s\s= render 'shared/appbar'\n\s\s\s\s= render 'shared/flash'",
      after: '%body'

    append_to_file 'application.html.haml',
      "\s\s\s\s#medium_screen_indicator\n\s\s\s\s#large_screen_indicator\n"
  end
  directory 'app/views/shared'

  require 'open-uri'
  create_file 'vendor/assets/stylesheets/normalize.css',
    open('https://necolas.github.io/normalize.css/latest/normalize.css').read

  create_file 'vendor/assets/stylesheets/_palette.scss',
    open('http://danlevan.github.io/google-material-color/dist/palette.scss').read

  remove_file 'app/assets/stylesheets/application.css'
  copy_file 'app/assets/stylesheets/application.scss'

  inside('app/assets/stylesheets') do
    run 'bitters install'

    # --------------------------------------------------------------------------
    # Convert to Modified 7-1 Architecture
    directory 'components'
    directory 'utils'
    directory 'layout'
    directory 'pages'

    # Move includes from _base.scss to application.scss
    gsub_file 'base/_base.scss', /^((.*variables.*)|(\/\/.*))$\n/, ''
    gsub_file 'base/_base.scss', '@import "', '@import "base/'
    base_includes = File.read('base/_base.scss')
    gsub_file 'application.scss', /^.*base.*$/, base_includes
    gsub_file 'application.scss', /(^$\n){2,}/, "\n"
    remove_file 'base/_base.scss'

    FileUtils.move 'base/_variables.scss', 'utils/_variables.scss'
    # --------------------------------------------------------------------------

    gsub_file 'base/_buttons.scss',
      /\#\{\$all-buttons\} \{.+\}/m,
      "\#{$all-buttons} {\n\s\s@include button;\n}"

    insert_into_file 'base/_layout.scss',
      "\n\s\smargin: 0;\n",
      after: "body {\n\s\sheight: 100%;"
    append_to_file 'base/_layout.scss', <<~SCSS
      main {
        background-color: $base-background-color;
        margin: $small-spacing;

        @media (min-width: $medium-screen) {
          margin: $base-spacing;
        }
      }
    SCSS

    insert_into_file 'utils/_variables.scss',
      "// Font Sizes\n$base-font-size: 1em;\n\n",
      before: "// Other Sizes"
    insert_into_file 'utils/_variables.scss',
      "\n$appbar-background-color: $dark-gray;",
      after: "$secondary-background-color: tint($base-border-color, 75%);"
    insert_into_file 'utils/_variables.scss',
      "\n$appbar-font-color: palette(White);",
      after: "$action-color: $blue;"
  end

  directory 'app/assets/javascripts'
  insert_into_file 'app/assets/javascripts/application.js',
    "//= require init\n",
    before: "//= require_tree ."
  insert_into_file 'app/assets/javascripts/application.js',
    "\n//= require jquery-ui/effect.all",
    after: "//= require jquery_ujs"

  pg_status = `pg_ctl status -D /usr/local/var/postgres`
  unless pg_status.include? "server is running"
    say "Starting postgres server for you..."
    run "pg_ctl start -D /usr/local/var/postgres"
    run "pg_ctl status -D /usr/local/var/postgres"
  end

  rails_command 'db:create'
  rails_command 'db:migrate'

  directory 'config/locales', force: true

  copy_file 'app/helpers/application_helper.rb', force: true
  copy_file 'spec/helpers/application_helper_spec.rb'

  copy_file 'spec/models/user_spec.rb', force: true
  copy_file 'spec/factories/users.rb', force: true

  generate :controller, 'Welcome', 'index'
  route "root to: 'welcome#index'"
  copy_file 'app/views/welcome/index.html.haml', force: true
  copy_file 'spec/features/welcome_spec.rb'

  copy_file 'spec/features/navigation_spec.rb'

  copy_file 'spec/features/devise/sessions_spec.rb'
  copy_file 'spec/features/devise/registrations_spec.rb'

  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end
