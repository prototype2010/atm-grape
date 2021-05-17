$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
require 'erb'
require 'yaml'
require 'active_record'

Bundler.require :default, ENV['RACK_ENV']

require_rel '../api'

DB_CONFIG = YAML.load(ERB.new(File.read('config/database.yml')).result)[ENV['RACK_ENV']]
ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.establish_connection(DB_CONFIG)
