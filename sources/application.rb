file 'app/controllers/application_controller.rb',
  processed_file('app/controllers/application_controller.rb')

file 'app/controllers/attachments_controller.rb',
  processed_file('app/controllers/attachments_controller.rb')

file 'app/controllers/concerns/public_controller.rb',
  processed_file('app/controllers/concerns/public_controller.rb')

file 'app/controllers/concerns/attachments_controller.rb',
  processed_file('app/controllers/concerns/attachments_actions.rb')

file 'app/helpers/application_helper.rb',
  processed_file('app/helpers/application_helper.rb')

file 'app/helpers/date_helper.rb',
  processed_file('app/helpers/date_helper.rb')

file 'app/models/attachment.rb',
  processed_file('app/models/attachment.rb')

file 'app/uploaders/attachment_uploader.rb',
  processed_file('app/uploaders/attachment_uploader.rb')

file 'app/views/layouts/application.html.erb',
  processed_file('app/views/layouts/application.html.erb')

file 'app/views/shared/_flash_messages.html.erb',
  processed_file('app/views/shared/_flash_messages.html.erb')

file 'config/environments/staging.rb',
  processed_file('config/environments/staging.rb')

file 'config/database.yml',
  processed_file('config/database.yml')

file_append 'config/initializers/assets.rb',
  '
Dir.glob("#{Rails.root}/app/assets/images/**/").each do |path|
  Rails.application.config.assets.paths << path
end
  '

file_inject('config/application.rb',
  "require_relative 'boot'",
  "\nENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'",
  :after
)
