source 'https://rubygems.org'

ruby "2.0.0"
gem 'rails', '3.2.11'
gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'    #,   '~> 3.2.3'
  gem 'coffee-rails'  #, '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby
  gem "therubyracer", :require => 'v8'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'heroku-api'
gem 'encryptor'

gem 'thin'
gem 'pg'
#gem 'rack-fiber_pool'
#gem 'em-synchrony'
#gem 'em-postgresql-adapter', :git => 'git://github.com/leftbee/em-postgresql-adapter.git'

gem 'chronic'
gem 'encryptor'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'annotate'
  gem 'rails_best_practices'

  # guard + spork
  gem 'rb-inotify'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rack-livereload'
  gem 'guard-spork'
  #gem 'spork-rails'

  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
end

group :test do
  gem 'sqlite3'
  gem 'faker'
  gem 'database_cleaner'
  gem 'nokogiri'
  gem 'xpath'
  gem 'timecop'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# To use debugger
#gem 'ruby-debug19', :require => 'ruby-debug'
