# Test coverage report is inacurrate if Spring is running (I've tried the
# solutions in simplecov's README).
unless defined?(Spring)
  require 'simplecov'
  SimpleCov.start 'rails'
end
