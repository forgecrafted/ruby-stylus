require 'stylus/tilt'

module Stylus
  class Railtie < ::Rails::Railtie

    config.after_initialize do |app|
      if app.assets
        Stylus.paths.concat app.assets.paths
        app.assets.register_engine '.styl', Tilt::StylusTemplate
      end
    end

  end
end