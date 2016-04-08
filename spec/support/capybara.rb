require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

class WarningSuppressor
  IGNORES = [
    /QFont::setPixelSize: Pixel size <= 0/,
    /CoreText performance note:/,
    /WebRTC-capable/
  ]

  class << self
    def write(message)
      if suppress?(message) then 0 else puts(message);1;end
    end

    private

    def suppress?(message)
      IGNORES.any? { |re| message =~ re }
    end
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
    phantomjs_logger: WarningSuppressor
  )
end

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 5

Capybara.add_selector(:data_js) do
  css { |name| "[data-js='#{name}']" }
end

Capybara::Screenshot.webkit_options = {
  width: 1024,
  height: 768
}

Capybara::Screenshot.autosave_on_failure = false
Capybara::Screenshot.prune_strategy = :keep_last_run

RSpec.configure do |config|
  config.after do |example|
    if example.metadata[:type] == :feature and example.metadata[:js] and example.exception.present?
      Capybara::Screenshot.screenshot_and_open_image
    end
  end
end
