# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'grape', '~> 1.5'

gem 'rack', '~> 2.2'

gem 'activerecord', '~> 6.1'
gem 'grape-entity', '~> 0.9.0'
gem 'grape-swagger', '~> 1.4'
gem 'pg', '~> 1.2'
gem 'require_all', '~> 3.0'

group :development do
  gem 'rake'
  gem 'thin'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'rack-test'
  gem 'rspec'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
gem 'sqlite3', '~> 1.4'

gem 'database_cleaner-active_record', '~> 2.0'

gem 'factory_bot', '~> 6.2'

gem 'rubocop', '~> 1.15'
