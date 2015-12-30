require 'config_reader'

class Config < ConfigReader
  self.config_file = 'config/config.yml'
  self.sekrets_file = 'config/config.yml.enc'
end
