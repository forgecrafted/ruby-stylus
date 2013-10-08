require 'stylus'
require 'stylus/sprockets'
require 'stylus/rails_tilt'

module Stylus
  # Internal: The Railtie responsible for integrate the Stylus library with
  # a Rails 3.2 (or 3.1) application.
  #
  # Some of the customizations of using Stylus alongside Rails:
  #
  # * The application will use the Stylus stylesheet engine;
  # * The Sprockets instance (present at Rails.application.assets) will be configured
  #   with the Stylus templates and the configurations defined at 'config.assets' will
  #   affect how Stylus compile your stylesheets;
  # * The assets load path - the folders living on app/assets/stylesheets,
  #   lib/assets/stylesheets and vendor/assets/stylesheets on your app - will be
  #   added to the Stylus path registry.
  class Railtie < ::Rails::Railtie

    # Internal: Set the Stylesheet engine to 'stylus', so the generator constants
    # will be loaded from the `Stylus::Generators` namespace.
    config.app_generators.stylesheet_engine :stylus

    # Internal: Initializer block that uses the Stylus.setup utility to configure
    # both Stylus and the Sprockets instance that lives on 'app.assets'. The entire
    # configuration object will be passed along.
    #
    # If you don't have the Asset Pipeline enabled on your application - done by
    # setting the 'config.assets.enabled' flag to false, this setup process will be
    # skipped.
    #
    # Returns nothing.
    config.assets.configure do |env|
      Stylus.setup(env, config.assets)
    end
  end
end