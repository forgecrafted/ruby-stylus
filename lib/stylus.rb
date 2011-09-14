require 'execjs'
require 'stylus/version'
require 'stylus/tilt' if defined?(::Tilt)
require 'stylus/railtie' if defined?(::Rails)

## Stylus
#
# `stylus` is a bridge between your Ruby code and the [Stylus](https://github.com/LearnBoost/stylus)
# library that runs on Node.js. It's aims to be a replacement for the
# [stylus_rails](https://github.com/lucasmazza/stylus_rails) gem and to support the Rails 3.1 asset pipeline
# (via [Tilt](https://github.com/rtomayko/tilt)) and other scenarios,
# backed by the [ExecJS](https://github.com/sstephenson/execjs) gem.
#
### Usage
#
# To compile a `.styl` file or an arbitrary String to .CSS using stylus, just use the `compile` method.
#
# `Stylus.compile(File.new('application.styl'))`
#
# A hash of options for the stylus API is accepted.
#
# `Stylus.compile(File.read('application.styl'), :compress => true)`
#
module Stylus
  class << self
    @@compress = false
    @@paths = []
    @@plugins = {}

    # Stores a list of plugins to import inside `Stylus`, with an optional hash.
    def use(*options)
      arguments = options.last.is_a?(Hash) ? options.pop : {}
      options.each do |plugin|
        @@plugins[plugin] = arguments
      end
    end
    alias :plugin :use

    # Retrieves all the registered plugins.
    def plugins
      @@plugins
    end

    # Returns the global load path `Array` for your stylesheets.
    def paths
      @@paths
    end

    # Replaces the global load path `Array` of paths.
    def paths=(val)
      @@paths = Array(val)
    end

    # Returns the global compress flag.
    def compress
      @@compress
    end

    # Sets the global flag for the `compress` option.
    def compress=(val)
      @@compress = val
    end

    # Compiles a given input - a `File`, `StringIO`, `String` or anything that responds to `read`.
    # Also accepts a hash of options that will be merged with the global configuration.
    def compile(source, options = {})
      source = source.read if source.respond_to?(:read)
      options = merge_options(options)
      context.call('compiler', source, options, plugins)
    end

    # Converts back an input of plain CSS to the `Stylus` syntax. The source object can be
    #  a `File`, `StringIO`, `String` or anything that responds to `read`.
    def convert(source)
      source = source.read if source.respond_to?(:read)
      context.call('convert', source)
    end

    # Returns a `Hash` of the given `options` merged with the default configuration.
    # It also concats the global load path with a given `:paths` option.
    def merge_options(options)
      _paths = options.delete(:paths)
      options = defaults.merge(options)
      options[:paths] = paths.concat(Array(_paths))
      options
    end

    # Returns the default `Hash` of options.
    def defaults
      { :compress => self.compress, :paths => self.paths }
    end

    # Return the gem version alongside with the current `Stylus` version of your system.
    def version
      "Stylus - gem #{VERSION} library #{context.call('version')}"
    end

    protected
    # Returns the `ExecJS` execution context.
    def context
      @@_context ||= backend.compile(script)
    end

    # Reads the default compiler script that `ExecJS` will execute.
    def script
      File.read(File.expand_path('../stylus/compiler.js',__FILE__))
    end

    # `ExecJS` 1.2.5+ doesn't support `require` statements on node anymore,
    # so we use a new instance of the `ExternalRuntime` with the old runner script.
    def backend
      @@_backend ||= ExecJS::ExternalRuntime.new(
        :name        => 'Node.js (V8)',
        :command     => ["nodejs", "node"],
        :runner_path => File.expand_path("../stylus/runner.js", __FILE__)
        )
    end
  end

  # Exports the `.node_modules` folder on the working directory so npm can
  # require modules installed locally.
  ENV['NODE_PATH'] = "#{File.expand_path('node_modules')}:#{ENV['NODE_PATH']}"
end
