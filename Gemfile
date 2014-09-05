source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby "2.1.1"
gem 'rails', '4.1.4'
gem 'pg', '~> 0.17.1'
gem 'unicorn', '~> 4.8.3'
gem 'foreman', '~> 0.74.0'

# Assets
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '~> 2.5.3'
gem 'coffee-rails', '~> 4.0.1'
gem 'jquery-rails', '~> 3.1.1'
gem 'jquery-ui-rails', '~> 4.2.1'

# JSON API
gem 'jbuilder', '~> 2.1.3'

# Authorization & Authentication
gem 'devise', '~> 3.2.4'
gem 'pundit', '~> 0.2.3'
gem 'omniauth-google-oauth2', '~> 0.2.4'

# Third-party gems
gem 'pusher', '~> 0.14.1'

gem 'simple_hashtag', '~> 0.1.9'
gem 'kaminari', '~> 0.16.1'
gem 'pg_search', '~> 0.7.6'
gem 'draper', '~> 1.3.1'

group :development do
  gem 'style-guide', '~> 1.1.1'
  gem 'rack-livereload', '~> 0.3.15'
  gem 'guard-livereload', '~> 2.2.0'
end

group :development, :test do
  gem 'pry-rails', '~> 0.3.2'
end

group :test do
  gem 'timecop', '~> 0.7.1'
  gem 'capybara', '~> 2.3.0'
  gem 'selenium-webdriver', '~> 2.42.0'
end

group :production do
  gem 'rails_12factor', '~> 0.0.2'
  gem 'newrelic_rpm', '~> 3.8.1.221'
end