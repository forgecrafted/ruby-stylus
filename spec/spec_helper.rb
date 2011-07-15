require 'support/helpers'
require 'support/matchers'
require 'support/generators/test_case'

RSpec.configure do |config|
  config.include Helpers

  config.after :each do
    Stylus.compress = false
    Stylus.paths = []
    Stylus.plugins.clear
  end
end
