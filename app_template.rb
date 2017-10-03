def source_paths
  # Array(super) + [File.join(__dir__, 'templates')]
  # [File.join(__dir__, 'templates')]
  [File.join(__dir__, 'templates'), File.join(__dir__, 'tasks')] + Array(super)
end

# path relative to snippets folder
def snippet(path)
  File.read(File.join(__dir__, 'snippets', *path.split('/')))
end

def method_missing(method_name, *args, &block)
  if File.exist? File.join(__dir__, 'tasks', "#{method_name}.rb")
    apply "#{method_name}.rb"
  else
    super
  end
end

specify_gems
insert_into_file 'Gemfile',
  "\nruby '#{RUBY_VERSION}'",
  after: "source 'https://rubygems.org'"

after_bundle do
  run 'bundle exec spring binstub rspec'

  modify_app_configs
  modify_env_configs

  run 'spring stop' # the following command might hang if we don't stop spring
  generate 'rspec:install'
  configure_rspec

  run 'bundle exec guard init rspec'
  gsub_file 'Guardfile', /^guard.*.do.*$/, 'guard :rspec, cmd: "bin/rspec" do'

  generate 'devise:install'
  generate 'devise', 'user'
  insert_into_file 'config/locales/devise.en.yml',
    snippet('config/locales/devise/en/registration_form.yml').chomp,
    after: 'registrations:'
  insert_into_file 'config/locales/devise.en.yml',
    snippet('config/locales/devise/en/session_form.yml').chomp,
    after: 'sessions:'

  customize_app_layout
  directory 'app/views/shared'

  add_vendor_stylesheets
  inside('app/assets/stylesheets') do
    remove_file 'application.css'
    copy_file 'application.scss'
    run 'bitters install'
  end
  convert_sass_to_7_1_architecture
  customize_bitters

  add_custom_javascripts

  ensure_pg_server_is_running
  rails_command 'db:create'
  rails_command 'db:migrate'

  directory 'config/locales', force: true

  copy_file 'app/helpers/application_helper.rb', force: true

  build_welcome_page

  directory 'spec', force: true

  copy_file '.rubocop.yml'
  copy_file 'CONTRIBUTING.md'

  git :init
  git add: '.'
  git commit: "-am 'Initial commit'"
end
