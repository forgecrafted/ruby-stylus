require 'rails'
require 'rails/test_help'
require 'rails/generators/test_case'

require 'active_support/railtie'
require 'action_controller/railtie'
require 'sprockets/railtie'
require 'stylus'

require 'active_support/core_ext/class/attribute_accessors'

require 'support/helpers'
require 'support/matchers'
require 'support/generators/test_case'

RSpec.configure do |config|
  config.include Helpers

  config.after :each do
    Stylus.compress = false
    Stylus.debug = false
    Stylus.paths = []
    Stylus.plugins.clear
  end
end
