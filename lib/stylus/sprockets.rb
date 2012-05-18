require 'stylus/tilt'
require 'stylus/import_processor'

# Public: The setup logic to configure both Stylus and Sprockets on any
# kind of application - Rails, Sinatra or Rack.
#
# Example
#
#  # mounting Sprockets as a Rack application with Stylus
#  assets = Sprockets::Environment.new
#  assets.append_path 'stylesheets'
#  Stylus.setup(assets)
#  run assets.index
module Stylus
  module Sprockets
    # Public: Configure a Sprockets environment with Stylus Tilt engine
    # and the ImportProcessor. It also accept a configuration Hash to
    # setup the load path and flags of the Stylus module.
    #
    # environment - A instance of Sprockets::Environment.
    # options     - The configuration Hash (default: {})
    #             :paths - An Array of paths to use the '@import' directive, defaults
    #                      to the `paths` attribute on the environment object.
    #              :debug - The Boolean value for the debug flag.
    #              :compress - The Boolean value for the debug compress.
    #
    # Example
    #
    #  assets = Sprockets::Environment.new
    #  Stylus.setup(assets, :compress => settings.production?)
    #
    # Returns nothing.
    def setup(environment, options = {})
      paths = options[:paths] || environment.paths
      directories = paths.select { |dir| dir.to_s =~ /stylesheets$/ }

      Stylus.paths.concat(directories)

      Stylus.debug = options.fetch(:debug, Stylus.debug)
      Stylus.compress = options.fetch(:compress, Stylus.compress)

      environment.register_engine('.styl', Tilt::StylusTemplate)
      environment.register_preprocessor('text/css', Stylus::ImportProcessor)
    end
  end
end