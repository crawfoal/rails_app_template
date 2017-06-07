insert_into_file 'spec/spec_helper.rb',
  snippet('spec/run_rubocop_after_suite.rb'),
  after: 'RSpec.configure do |config|'
prepend_to_file 'spec/spec_helper.rb', snippet('spec/webmock_config.rb')
prepend_to_file 'spec/spec_helper.rb', snippet('spec/simplecov_config.rb')
gsub_file 'spec/spec_helper.rb', '=begin', ''
gsub_file 'spec/spec_helper.rb', '=end', ''
comment_lines 'spec/spec_helper.rb', 'config.profile_examples = 10'

uncomment_lines 'spec/rails_helper.rb', /.*spec\/support\/\*\*\/\*\.rb.*/
gsub_file 'spec/rails_helper.rb',
  "config.use_transactional_fixtures = true",
  "config.use_transactional_fixtures = false"

append_to_file '.gitignore', "\nspec/examples.txt\n"
append_to_file '.gitignore', "coverage/**\n"
