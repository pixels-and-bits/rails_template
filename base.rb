# use this for local installs
ENV['SOURCE'] ||= 'https://github.com/pixels-and-bits/rails_template/raw/master'

apply "#{ENV['SOURCE']}/sources/helpers.rb"

%w(
  prompts
  gems
  application_config
  config_sekrets
  simple_form
  friendly_id
  kaminari
  sidekiq
  devise
  accounts
  admin_accounts
  admin
  pages
  capistrano
  routes
  rake_tasks
  application
  assets
  permissions
).each do |f|
  apply "#{ENV['SOURCE']}/sources/#{f}.rb"
end

rake 'db:bounce'

git :init
git add: '.'
git commit: '-a -m "Initial commit"'
