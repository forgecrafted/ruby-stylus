require 'stylus'

RSpec.configure do |config|

  config.after :each do
    Stylus.compress = false
    Stylus.paths = []
    Stylus.plugins.clear
  end
end

def fixture_root
  File.expand_path('../fixtures', __FILE__)
end

def fixture(name)
  stylus = File.read(File.join(fixture_root, "#{name}.styl"))
  css    = File.read(File.join(fixture_root, "#{name}.css"))
  [stylus, css]
end

