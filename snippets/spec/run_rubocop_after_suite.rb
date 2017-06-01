config.after(:suite) do
  system 'rubocop --auto-correct'
end
