require 'stylus/tilt'
module Stylus
  ### Stylus Railtie
  #
  # `Railtie` responsible for injecting `stylus` inside the
  # Rails application and the `Sprockets` Asset Pipeline.
  class Railtie < ::Rails::Railtie

    config.app_generators.stylesheet_engine :stylus
    
    # Includes the `Rails` asset load path into `stylus` so any
    # `.styl` file inside it can be imported by the `stylus` API.
    initializer "stylus.initialize", :after => "sprockets.environment" do |app|
      Stylus.compress = app.config.assets.compress
      Stylus.paths.concat app.assets.paths

      app.assets.register_engine '.styl', Tilt::StylusTemplate      
    end
  end
end