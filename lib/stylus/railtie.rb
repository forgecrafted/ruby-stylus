require 'stylus/tilt'
module Stylus
  ### Stylus Railtie
  #
  # `Railtie` responsible for injecting `stylus` inside the
  # Rails application and the `Sprockets` Asset Pipeline.
  class Railtie < ::Rails::Railtie

    config.app_generators.stylesheet_engine :stylus

    initializer :setup_stylus do |app|
      app.assets.register_engine '.styl', Tilt::StylusTemplate
    end

    # Includes the `Rails` asset load path into `stylus` so any
    # `.styl` file inside it can be imported by the `stylus` API.
    config.after_initialize do |app|
      Stylus.compress = config.assets.compress
      Stylus.paths.concat app.assets.paths
    end
  end
end