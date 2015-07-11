source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby "2.2.2"
gem 'rails', '4.2.3'
gem 'pg', '~> 0.18.2'
gem 'passenger', '~> 5.0.7'
gem 'foreman', '~> 0.78.0'

# Assets
gem 'sass-rails', '~> 5.0.3'
gem 'uglifier', '~> 2.7.1'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails', '~> 4.0.3'
gem 'jquery-ui-rails', '~> 5.0.5'

# JSON API
gem 'jbuilder', '~> 2.3.1'

# Authorization & Authentication
gem 'devise', '~> 3.5.1'
gem 'pundit', '~> 1.0.0'
gem 'omniauth-google-oauth2', '~> 0.2.4'

# Pub/sub
gem 'message_bus', '~> 1.0.9'

gem 'simple_hashtag', '~> 0.1.9'
gem 'kaminari', '~> 0.16.1'
gem 'pg_search', '~> 1.0.3'
gem 'draper', '~> 2.1.0'

group :development do
  gem 'style-guide', '~> 1.1.1'
  gem 'rack-livereload', '~> 0.3.15'
  gem 'guard-livereload', '~> 2.4.0'
  gem 'quiet_assets', '~> 1.1.0'
  gem 'guard-minitest', '~> 2.4.4'
  gem 'guard', '~> 2.12.5'
end

group :development, :test do
  gem 'pry-rails', '~> 0.3.2'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'capybara', '~> 2.4.3'
  gem 'selenium-webdriver', '~> 2.46.2'
  gem 'mocha', '~> 1.1.0'
end

gem "codeclimate-test-reporter", group: :test, require: nil

group :production do
  gem 'rails_12factor', '~> 0.0.2'
  gem 'newrelic_rpm', '~> 3.12.1.298'
  gem 'skylight', '~> 0.6.0'
end
