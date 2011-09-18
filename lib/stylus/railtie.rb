require 'stylus/tilt'
module Stylus
  ### Stylus Railtie
  #
  # `Railtie` responsible for injecting `Stylus` inside the
  # Rails application and the `Sprockets` Asset Pipeline.
  class Railtie < ::Rails::Railtie

    config.app_generators.stylesheet_engine :stylus

    initializer :setup_stylus do |app|
      app.assets.register_engine '.styl', Tilt::StylusTemplate
    end

    # After initialization block to inspect the `Sprockets` configuration
    # And reflect it on the `Stylus` module.
    # It also includes the `Rails` asset load path into `Stylus` so any
    # `.styl` file inside it can be imported by the `Stylus` API.
    config.after_initialize do |app|
      Stylus.compress = app.config.assets.compress
      Stylus.debug = app.config.assets.debug
      Stylus.paths.concat app.assets.paths
    end
  end
end