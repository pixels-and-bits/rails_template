# UI/Frontend
gem 'jquery-turbolinks'
gem 'bootstrap-sass'
gem 'draper'
gem 'faker'
gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'simple_form'

# configuration
gem 'config_reader'
gem 'sekrets'
gem 'request_store'

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

# debugging
gem 'pry-rails'

gem_group :development do
  # lazy mans way to eliminating N+1
  gem 'bullet'

  # pin versions after bundling
  gem 'pessimize'

  # less noisy dev logs
  gem 'quiet_assets'

  # deployment stuff
  gem 'airbrussh', require: false
  gem 'capistrano'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
  gem 'capistrano-rails'
  gem 'capistrano-sidekiq'
end

gem_group :test do
  gem 'rspec-rails'
end

# run 'bundle install --path vendor/bundle'
run 'bundle install'
