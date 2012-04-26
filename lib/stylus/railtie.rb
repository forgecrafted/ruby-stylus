require 'stylus/sprockets'

module Stylus
  ### Stylus Railtie
  #
  # `Railtie` that hooks `stylus` inside a Rails application.
  class Railtie < ::Rails::Railtie

    config.app_generators.stylesheet_engine :stylus

    initializer 'stylus.register', :after => 'sprockets.environment', :group => :all do |app|
      if app.config.assets.enabled
        Stylus::Sprockets.register(app.assets)
      end
    end

    # Initializer block to inspect the `Sprockets` configuration
    # And reflect it on the `Stylus` module;
    # It also includes the `Rails` asset load path into `Stylus` so any
    # `.styl` file inside it can be imported by the `Stylus` API.
    initializer 'stylus.config', :after => :append_assets_path, :group => :all do |app|
      sprockets = app.config.assets
      paths     = sprockets.paths.select { |dir| dir.to_s.ends_with?('stylesheets') }
      if sprockets.enabled
        Stylus.compress = sprockets.compress
        Stylus.debug    = sprockets.debug
        Stylus.paths.concat paths
      end
    end
  end
end