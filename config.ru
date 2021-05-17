require_relative './initializer'

require File.expand_path('config/environment', __dir__)
ActiveRecord::Base.establish_connection(DB_CONFIG)

run ATM::API
