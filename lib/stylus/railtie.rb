require 'stylus/tilt'

module Stylus
  class Railtie < ::Rails::Railtie

    initializer :setup_stylus do |app|
      config.app_generators.stylesheet_engine :styl
      next unless app.config.assets.enabled

      require 'sprockets'
      require 'sprockets/engines'
      Sprockets.register_engine '.styl', Tilt::StylusTemplate
    end

    config.after_initialize do |app|
      Stylus.paths.concat app.assets.paths
    end

  end
end