environment snippet('config/mailer_url_optns.rb'), env: ['development', 'test']
uncomment_lines 'config/environments/development.rb', /missing_translations/
uncomment_lines 'config/environments/test.rb', /missing_translations/
