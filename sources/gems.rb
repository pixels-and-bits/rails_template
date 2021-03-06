gem 'thor', '0.19.1'
gem 'pg'

# UI/Frontend
gem 'jquery-turbolinks'
gem 'bootstrap-sass'
gem 'momentjs-rails'
gem 'bootstrap3-datetimepicker-rails'
gem 'draper', '~> 3.0.0.pre1'
gem 'faker'
gem 'kaminari'
gem 'simple_form'
gem 'sidekiq'
gem 'jstz-rails', git: 'https://github.com/vanetten/jstz-rails.git'
gem 'browser-timezone-rails'

# configuration
gem 'config_reader'
gem 'sekrets'
gem 'request_store'

# helpers
gem 'coerce'

# auth
gem 'devise'

# slugged URLs
gem 'friendly_id'

# uploads
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'

# search
gem 'ransack'

gem_group :development do
  # debugging
  gem 'pry-rails'

  # lazy mans way to eliminating N+1
  gem 'bullet'

  # pin versions after bundling
  gem 'pessimize'

  # deployment stuff
  gem 'airbrussh', require: false
  gem 'capistrano'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
  gem 'capistrano-rails'
  gem 'capistrano-sidekiq'
  gem 'capistrano-rails-console'

  # gem 'guard-bundler'
  # gem 'guard-rspec'
  # gem 'guard-migrate'
  # gem 'terminal-notifier'
  # gem 'terminal-notifier-guard'
end

gem_group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rspec-rails'
end

gem_group :development, :test do
  gem 'factory_girl_rails'
end

# run 'bundle install --path vendor/bundle'
run 'bundle install --path vendor/bundle'
