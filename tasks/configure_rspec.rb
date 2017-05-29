uncomment_lines 'spec/rails_helper.rb', /.*spec\/support\/\*\*\/\*\.rb.*/
gsub_file 'spec/rails_helper.rb',
  "config.use_transactional_fixtures = true",
  "config.use_transactional_fixtures = false"

prepend_to_file 'spec/spec_helper.rb', snippet('spec/webmock_config.rb')
