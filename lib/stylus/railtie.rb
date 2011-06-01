require 'stylus/tilt'

module Stylus
  class Railtie < ::Rails::Railtie

    initializer :setup_stylus do |app|
      config.app_generators.stylesheet_engine :styl
    end

    config.after_initialize do |app|
      Stylus.paths.concat app.assets.paths
      app.assets.register_engine '.styl', Tilt::StylusTemplate
    end

  end
end