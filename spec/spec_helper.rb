require 'stylus'

RSpec.configure do |config|

  config.after :each do
    Stylus.compress = false
    Stylus.paths = []
  end
end

def fixture_root
  File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures')
end

def fixture(name)
  stylus = File.read(File.join(fixture_root, "#{name}.styl"))
  css    = File.read(File.join(fixture_root, "#{name}.css"))
  [stylus, css]
end

