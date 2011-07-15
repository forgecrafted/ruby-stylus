require 'stylus/tilt'
require 'sprockets'
### Stylus Railtie
# `Railtie` responsible for injecting `stylus` inside the
# Rails application and the `Sprockets` Asset Pipeline.
module Stylus
  class Railtie < ::Rails::Railtie

    config.app_generators.stylesheet_engine :stylus

    Sprockets::Engines #autoloading
    Sprockets.register_engine '.styl', Tilt::StylusTemplate

    # Includes the `Rails` asset load path into `stylus` so any
    # `.styl` file inside it can be imported.
    config.after_initialize do |app|
      Stylus.paths.concat app.assets.paths
    end

  end
end