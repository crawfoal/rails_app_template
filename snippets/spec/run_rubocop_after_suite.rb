config.after(:suite) do
  puts "\n\n"
  system 'rubocop --auto-correct'
end
