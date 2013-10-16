require 'stylus'
require 'stylus/tilt/stylus'
require 'stylus/tilt/rails'
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
  # Public: Configure a Sprockets environment with Stylus Tilt engine
  # and the ImportProcessor. It also accept a configuration Hash to
  # setup the load path and flags of the Stylus module.
  #
  # environment - A instance of Sprockets::Environment.
  # options     - The configuration Hash (default: {})
  #             :rails - a flag to inform that the current application is a Rails app.
  #             :paths - An Array of paths to use the '@import' directive, defaults
  #                      to the `paths` attribute on the environment object.
  #             :debug - The Boolean value for the debug flag.
  #             :compress - The Boolean value for the debug compress.
  #
  # Example
  #
  #  assets = Sprockets::Environment.new
  #  Stylus.setup(assets, compress: settings.production?)
  #
  # Returns nothing.
  def self.setup(environment, options = {})
    paths = options[:paths] || environment.paths

    Stylus.paths.concat(paths)

    Stylus.debug = options.fetch(:debug, Stylus.debug)
    Stylus.compress = options.fetch(:compress, Stylus.compress)
    template = detect_template_hander(options)
    environment.register_engine('.styl', template)
    environment.register_preprocessor('text/css', Stylus::ImportProcessor)
  end

  # Internal: Gets the desired Tilt template handler to the current configuration.
  # If a 'rails' option is present then the Rails specific template will be
  # returned instead of the default Stylus Tilt template.
  #
  # Returns a Tilt::Template children class.
  def self.detect_template_hander(options = {})
    if options[:rails]
      Stylus::Rails::StylusTemplate
    else
      Tilt::StylusTemplate
    end
  end
end
