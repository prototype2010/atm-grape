ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start do
  minimum_coverage 90
  add_filter '/spec/'
end

require 'database_cleaner-active_record'
require 'rack/test'
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'grape_bootstrap_development')

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  # config.before(:suite) do
  #   DatabaseCleaner.clean_with(:truncation)
  #   DatabaseCleaner.strategy = :transaction
  # end

  config.before(:each) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  # config.before do
  #   DatabaseCleaner.start
  # end
  #
  # config.after do
  #   DatabaseCleaner.clean
  # end
end
