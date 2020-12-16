source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bcrypt'
gem 'bootsnap'
gem 'image_processing'
gem 'pg'
gem 'puma'
gem 'rails', '~> 6.0.3', '>= 6.0.3.1'
gem 'sass-rails'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'turbolinks'
gem 'webpacker'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'sprockets', '3.7.2' # greater versions break on windows https://github.com/rails/sprockets/issues/283
end

group :development do
  gem 'listen'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
