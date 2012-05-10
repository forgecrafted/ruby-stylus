require 'stylus/tilt'
require 'stylus/import_processor'

module Stylus
  def self.setup(environment, options = {})
    paths = options[:paths] || environment.paths
    directories = paths.select { |dir| dir.to_s =~ /stylesheets$/ }

    Stylus.paths.concat(directories)

    Stylus.debug = options.fetch(:debug, Stylus.debug)
    Stylus.compress = options.fetch(:compress, Stylus.compress)

    environment.register_engine('.styl', Tilt::StylusTemplate)
    environment.register_preprocessor('text/css', Stylus::ImportProcessor)
  end
end