source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 5.0.0.1'
gem 'pg'
gem 'puma', '~> 3.0'

# gem 'jquery-rails'
gem 'activeadmin', github: 'activeadmin'
gem 'active_model_serializers', '~> 0.10.0'
gem 'cancancan',                '~> 1.10'
gem 'devise',                   '>= 4.2.0'
gem 'draper',                   '> 3.x'
gem 'erubis'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'redcarpet',                '~>3.3'
gem 'sass-rails',               '~> 5.0'
gem 'turbolinks',               '~> 5'
gem 'uglifier',                 '>= 1.3.0'
gem 'jbuilder',                 '~> 2.6.0'
gem 'two_factor_authentication', github: 'Houdini/two_factor_authentication'
gem 'rqrcode'
gem 'devise_invitable'

group :production do
  gem 'rails_12factor'
end

group :assets do
   gem 'coffee-rails'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
end

group :development do
  gem "binding_of_caller"
  gem "better_errors"
  gem "letter_opener"
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
end

group :test do
  gem 'capybara', '~> 2.8.1'
  gem "codeclimate-test-reporter", require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'json-schema'
  gem 'poltergeist'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver', '~> 2.53.4'
  gem 'shoulda-matchers', '~> 3.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
