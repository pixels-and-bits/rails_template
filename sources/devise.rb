generate 'devise:install'

file_str_replace(
  'config/initializers/devise.rb',
  '# config.secret_key.*',
  'config.secret_key = Config.devise.secret_key'
)

file_str_replace(
  'config/initializers/devise.rb',
  'please-change-me-at-config-initializers-devise@example.com',
  "info@#{@app_name}.com"
)
