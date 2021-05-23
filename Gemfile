source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'rails', '6.0.3.5'

# Assets
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'

# Authentication for Slack
gem 'devise', github: 'heartcombo/devise', branch: 'ca-omniauth-2'
gem 'ginjo-omniauth-slack', require:'omniauth-slack'
gem "omniauth-rails_csrf_protection"

# 権限
gem "pundit"
gem "administrate"

# API
gem 'slack-ruby-client'
gem 'active_model_serializers', '~> 0.10.0'

# Application server
gem 'puma', '~> 4.1'
gem 'carrierwave'

# Config
gem 'config'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'parser', '< 2.6.6.0'

# Database
gem 'mysql2', '>= 0.4.4'
gem 'redis-rails'

# Model
gem 'enum_help'
gem 'active_hash'
gem 'public_uid'

# UI/UX
gem 'rails-i18n'
gem 'devise-i18n'
gem 'jbuilder', '~> 2.7'
gem "tailwindcss-rails", "~> 0.3.3"
gem 'slim-rails'
gem 'html2slim'

gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Email
  gem 'letter_opener_web'

  # Test
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'simplecov', require: false

  #CLI
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'

  # Debugger
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'

  # Code analyze
  gem 'rails_best_practices'
  gem 'rubocop'
  gem 'rubocop-checkstyle_formatter'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  # N + 1問題
  gem 'bullet'

  gem 'foreman'
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'

end

group :test do
  gem 'capybara'
  gem 'faker'
  gem 'webdrivers'
  gem "webmock"
  gem 'vcr'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
