source 'https://rubygems.org'

ruby "2.4.1"

gem 'rails', '~> 5.1.1'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.9', '>= 3.9.1'
gem 'rack-timeout', '~> 0.4.2'
gem 'foreman', '~> 0.84.0'

# Assets
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'jquery-ui-rails', '~> 5.0.5'

# Default Rails Gems
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
# gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# Authorization & Authentication
gem 'devise', '~> 4.3'
gem 'bcrypt', '~> 3.1.7'
gem 'pundit', '~> 1.1'
gem 'omniauth-google-oauth2', '~> 0.5.0'

# Pub/sub
gem 'message_bus', '~> 2.0', '>= 2.0.2'
gem 'redis', '~> 3.3', '>= 3.3.3'

# Misc.
gem 'simple_hashtag', '~> 0.1.9'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'pg_search', '~> 2.0', '>= 2.0.1'
gem 'draper', '~> 3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'mocha', '~> 1.2', '>= 1.2.1'
end

group :production do
  gem 'rails_12factor', '~> 0.0.3'
  gem 'newrelic_rpm', '~> 4.2', '>= 4.2.0.334'
end
