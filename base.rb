# use this for local installs
ENV['SOURCE'] ||= 'http://github.com/pixels-and-bits/strappy/raw/master'

apply "#{ENV['SOURCE']}/sources/helpers.rb"

%w(
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
  assets
).each do |f|
  apply "#{ENV['SOURCE']}/sources/#{f}.rb"
end

rake 'db:migrate'


  # generators
  # admin
  # home_page
  # rake_tasks
  # javascripts
  # initializers
