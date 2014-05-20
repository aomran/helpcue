source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby "2.1.1"
gem 'rails', '4.0.5'
gem 'pg'

# Assets
gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'devise'
gem "pundit"
gem 'pusher'
gem 'simple_hashtag'
gem 'intercom-rails', '~> 0.2.24'
gem 'kaminari'
gem 'pg_search'
gem 'chronic_duration'
gem 'draper', '~> 1.3'
gem "omniauth-google-oauth2"

group :development do
  gem 'style-guide'
  gem 'rack-livereload'
  gem 'guard-livereload'
  gem 'brakeman', :require => false
end

group :development, :test do
  gem 'pry-rails'
end

group :test do
  gem 'timecop'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'bullet'
end

group :production do
  gem 'rails_12factor'
  gem 'unicorn'
  gem 'newrelic_rpm'
end