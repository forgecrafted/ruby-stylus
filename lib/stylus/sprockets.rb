require 'stylus/tilt'
require 'stylus/import_processor'


module Stylus
  module Sprockets
    def self.register(env)
      env.register_engine '.styl', Tilt::StylusTemplate
      env.register_preprocessor 'text/css', Stylus::ImportProcessor
    end
  end
end