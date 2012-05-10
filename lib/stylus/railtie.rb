require 'stylus'
module Stylus
  ### Stylus Railtie
  #
  # `Railtie` that hooks `stylus` inside a Rails application.
  class Railtie < ::Rails::Railtie

    config.app_generators.stylesheet_engine :stylus

    # Initializer block to inspect the `Sprockets` configuration
    # And reflect it on the `Stylus` module;
    # It also includes the `Rails` asset load path into `Stylus` so any
    # `.styl` file inside it can be imported by the `Stylus` API.
    initializer 'stylus.setup', :after => :append_assets_path, :group => :all do |app|
      config = app.config.assets
      if config.enabled
        Stylus.setup(app.assets, config)
      end
    end
  end
end