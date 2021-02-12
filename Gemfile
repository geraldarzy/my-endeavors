source 'http://rubygems.org'

gem 'sinatra'
gem 'activerecord', '~> 5.2', '>= 4.2.6', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'  #gives access to prebuilt rake tasks
gem 'rake'
gem 'require_all'         #lets us require all app files at once
gem 'pg'
gem 'thin'                #server we are using
gem 'shotgun'             #allows automatic refresh
gem 'pry'                 #debugging tool
gem 'bcrypt'              #handles authentication password_digest
gem 'tux'                 #associations sandbox for objects

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
