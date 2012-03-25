require 'stylus/tilt'
require 'stylus/import_processor'

module Stylus
  ### Stylus Railtie
  #
  # `Railtie` that hooks `stylus` inside a Rails application.
  class Railtie < ::Rails::Railtie

    config.app_generators.stylesheet_engine :stylus

    initializer 'stylus.register', :after => 'sprockets.environment', :group => :all do |app|
      if app.config.assets.enabled
        app.assets.register_engine '.styl', Tilt::StylusTemplate
        app.assets.register_preprocessor 'text/css', Stylus::ImportProcessor
      end
    end

    # Initializer block to inspect the `Sprockets` configuration
    # And reflect it on the `Stylus` module;
    # It also includes the `Rails` asset load path into `Stylus` so any
    # `.styl` file inside it can be imported by the `Stylus` API.
    initializer 'stylus.config', :after => :append_assets_path, :group => :all do |app|
      sprockets = app.config.assets
      if sprockets.enabled
        Stylus.compress = sprockets.compress
        Stylus.debug    = sprockets.debug
        Stylus.paths.concat sprockets.paths
      end
    end
  end
end