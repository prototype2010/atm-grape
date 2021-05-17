require 'grape'
require 'grape-entity'
require 'factory_bot'
require 'json'
require 'active_record'
require 'erb'
require 'yaml'

DB_CONFIG = YAML.load(ERB.new(File.read('config/database.yml')).result)[ENV['RACK_ENV']]

require_relative './validation/validation_helpers'
require_relative './exceptions/no_nominal_exception'
require_relative './exceptions/not_enough_money_exception'
require_relative './utils/count_algorithm'
require_relative './models/note'
require_relative './spec/factories/note'
require_relative 'api/base'
