source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'mysql2'
gem 'jquery-rails'
gem 'omniauth-facebook'
gem 'cancan'
gem 'validates_email_format_of'
gem 'colorize'
gem 'best_in_place'
gem 'friendly_id'
gem 'haml'
gem 'capistrano', require: false
gem 'capistrano_colors', require: false
gem 'koala'
gem 'newrelic_rpm'
gem 'daemons'
gem 'delayed_job_active_record'
gem 'delayed_job_web'
gem 'whenever', require: false
gem 'versionist'
gem 'stalker'
gem 'daemons', require: false
gem 'paperclip'
gem 'aws-sdk', '~> 1.3.4'
gem 'mails_viewer'
gem 'will_paginate'
gem 'rapns'
gem 'pg'

group :assets do
  gem 'sass' #so other gems don't alert
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platform => :ruby
  gem 'bootstrap-sass'
  gem 'font-awesome-sass-rails'
  gem 'jquery-datatables-rails'
  gem 'select2-rails'
end

group :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'turn', :require => false
  gem 'minitest'
  gem "mocha"
  gem 'rspec-rails'
  gem 'capybara'
  gem 'fabrication'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
  gem 'rb-inotify' if /linux/ =~ RUBY_PLATFORM
  gem 'guard-rspec'
  gem 'railroady'
  gem 'template_rider'
  gem 'faker'
  gem 'spork'
  gem 'thin'
end
