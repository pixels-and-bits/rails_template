file_inject('config/application.rb',
  "  end",
  '
    # Auto Load
    config.autoload_paths += %W(
      #{config.root}/app/permissions
      #{config.root}/lib
    )

    config.eager_load_paths += %W(
      #{config.root}/app/permissions
      #{config.root}/lib
    )

    config.generators do |g|
      g.orm              :active_record
      g.template_engine  :erb
      g.test_framework   :rspec, fixture: false
      g.assets           false
      g.helper           false
      g.jbuilder         false
      g.controller_specs false
      g.view_specs       false
      g.decorator        false
      g.decorator_specs  false
    end

    config.action_mailer.default_url_options = {
      host: Config.host_name
    }
  ',
  :before
)

file_str_replace(
  'config/secrets.yml',
  'ENV["SECRET_KEY_BASE"]',
  'Config.secret_key_base'
)
