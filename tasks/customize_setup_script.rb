insert_into_file 'bin/setup',
  snippet('bin/setup/db_populate.rb').chomp,
  after: "system! 'bin/rails db:setup'"
