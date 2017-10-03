

  puts "\n== Loading sample data =="
  system! 'bin/rails db:populate' unless Rails.env.production?
