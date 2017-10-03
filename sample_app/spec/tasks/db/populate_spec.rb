require 'rails_helper'

RSpec.describe 'rake db:populate', type: :task do
  before(:all) do
    Rake::Task['db:populate'].execute
  end

  after(:all) do
    DatabaseCleaner.clean_with :deletion
    Rails.application.load_seed
  end

  it 'preloads the Rails environment' do
    expect(task.prerequisites).to include 'environment'
  end

  it 'adds 50 users to the database' do
    expect(User.count).to eq 50
  end
end
