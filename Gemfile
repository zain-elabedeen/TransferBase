source 'https://rubygems.org'
ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# GraphQL gem
gem 'graphql', '~> 1.9.15'
# Boot rails faster
gem 'bootsnap', '~> 1.3.0'
# Basic auth
gem 'devise', '~> 4.4.3'
# API auth
gem 'devise-jwt', '~> 0.5.9'
# Postgres database 
gem 'pg', '~> 0.18.2'
# Web server
gem 'puma', '~> 3.0'
# CORS config
gem 'rack-cors', '~> 1.0.5'
# enhancing the ruby shell
gem 'awesome_print'

group :development, :test do
  # Detect N+1 
  gem 'bullet', '~> 5.7.5'
  # Test data
  gem 'factory_bot_rails', '~> 4.8.2'
  # Debugger
  gem 'pry-byebug', '~> 3.3.0', platform: :mri
  # Test suite
  gem 'rspec-rails', '~> 3.8.0'
  # Load environment variables from .env into ENV in development, test
  gem 'dotenv-rails', '~> 2.7.5'
end

group :development do
  # Doc the schema in the models
  gem 'annotate', '~> 2.6.5'
  # Better error page
  gem 'better_errors', '~> 2.1.1'
  # Static analysis security
  gem 'brakeman', '~> 4.4.0'
  # Desplay emails in browser
  gem 'letter_opener', '~> 1.4.1'
  # Code linter
  gem 'rubocop', '~> 0.65.0'
  # Application loader
  gem 'spring'
  # File watch
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Mount the GraphiQL IDE
  gem 'graphiql-rails', '~> 1.7.0'
end

group :test do
  # Generate test date
  gem 'faker', '~> 1.7.3'
  # Test helpers
  gem 'shoulda-matchers', '~> 3.1.1'
  # Code coverage
  gem 'simplecov', '~> 0.13.0', require: false
  # Mock http requests
  gem 'webmock', '~> 2.3.2'
end