file 'lib/config.rb',
  processed_file("lib/config.rb")

# @site_name = ask("What is the name of this website (page title)")

@site_name = "remove me"

file 'config/config.yml',
  processed_file("config/config.yml")

unless File.exist?('.sekrets.key')

  puts "\nPlease type in a new sekrets key: "
  new_key = STDIN.noecho(&:gets).chomp

  file '.sekrets.key',
    new_key

end

unless File.exist?('config/config.yml.enc')

  key = File.read('.sekrets.key').chomp

  file 'config/config.yml.txt',
    processed_file("config/config.yml.txt")

  run "bundle exec sekrets write config/config.yml.enc config/config.yml.txt -k #{key}"

  rm 'config/config.yml.txt'

end

file_inject(
  "config/application.rb",
  "require 'rails/all'",
  "require './lib/config.rb'",
  :after
)
