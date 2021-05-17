require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems'
  exit e.status_code
end

task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('config/environment', __dir__)
end

desc 'API Routes'
task routes: :environment do
  [ATM::API]
    .map(&:routes)
    .flatten
    .each do |api|
    method = api.request_method.ljust(10)
    path   = api.path
    puts "#{method} #{path}"
  end
end

# Load tasks
Dir.glob('lib/tasks/*.rake').each { |task| load task }
