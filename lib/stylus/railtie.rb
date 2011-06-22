### Stylus Railtie
# `Railtie` responsible for injecting `stylus` inside the
# Rails application and the `Sprockets` Asset Pipeline.

require 'stylus/tilt'

module Stylus
  class Railtie < ::Rails::Railtie

    initializer :setup_stylus do |app|
      config.app_generators.stylesheet_engine :styl
      next unless app.config.assets.enabled

      # Loading `Sprockets` before Rails so we can register our own Engine.
      require 'sprockets'
      require 'sprockets/engines'
      Sprockets.register_engine '.styl', Tilt::StylusTemplate
    end

    # Includes the `Rails` asset load path into `stylus` so any
    # `.styl` file inside it can be imported.
    config.after_initialize do |app|
      Stylus.paths.concat app.assets.paths
    end

  end
end