require_relative './api/base'
require_relative './middleware/auth_service_user'

require File.expand_path('../config/environment', __FILE__)
ActiveRecord::Base.establish_connection

Twitter::API.compile!
run Twitter::API