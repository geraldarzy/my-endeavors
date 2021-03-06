ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

#establish connection to sqlite3 database and store db file in db directory
ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :database => "my_endeavors_#{ENV['SINATRA_ENV']}" 
)

require './app/controllers/application_controller'
require_relative "../app/validators/dropbox_link_validator"
require_all 'app'
