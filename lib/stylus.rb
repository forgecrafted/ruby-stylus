require 'stylus/runtime'
require 'stylus/source'
require 'stylus/version'
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
  extend Runtime
  class << self
    @@compress = false
    @@debug    = false
    @@paths    = []
    @@imports  = []
    @@plugins  = {}

    # Stores a list of plugins to import inside `Stylus`, with an optional hash.
    def use(*options)
      arguments = options.last.is_a?(Hash) ? options.pop : {}
      options.each do |plugin|
        @@plugins[plugin] = arguments
      end
    end
    alias :plugin :use

    # Stores a list of stylesheets to import on every compile process.
    def import(*paths)
      if paths.any?
        @@imports = @@imports.concat(paths)
      end
    @@imports
    end
    alias :imports :import

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

    # Returns the `debug` flag used to set the `linenos` and `firebug` option for Stylus.
    def debug
      @@debug
    end
    alias :debug? :debug

    # Marks the `nib` plugin to be loaded and included on every stylesheet.
    def nib=(flag)
      if flag
        use :nib
        import :nib
      end
    end

    # Sets the `debug` flag.
    def debug=(val)
      @@debug = val
    end

    # Returns the global compress flag.
    def compress
      @@compress
    end
    alias :compress? :compress

    # Sets the global flag for the `compress` option.
    def compress=(val)
      @@compress = val
    end

    # Compiles a given input - a plain String, `File` or some sort of IO object that
    # responds to `read`.
    # It accepts a hash of options that will be merged with the global configuration.
    # If the source has a `path`, it will be expanded and used as the :filename option
    # So the debug options can be used.
    def compile(source, options = {})
      if source.respond_to?(:path) && source.path
        options[:filename] ||= File.expand_path(source.path)
      end
      source  = source.read if source.respond_to?(:read)
      options = merge_options(options)
      exec('compile', source, options, plugins, imports)
    end

    # Converts back an input of plain CSS to the `Stylus` syntax. The source object can be
    #  a `File`, `StringIO`, `String` or anything that responds to `read`.
    def convert(source)
      source = source.read if source.respond_to?(:read)
      exec('convert', source)
    end

    # Returns a `Hash` of the given `options` merged with the default configuration.
    # It also concats the global load path with a given `:paths` option.
    def merge_options(options)
      filename = options[:filename]

      _paths  = options.delete(:paths)
      options = defaults.merge(options)
      options[:paths] = paths.concat(Array(_paths))
      if filename
        options = options.merge(debug_options)
      end
      options
    end

    # Returns the default `Hash` of options:
    # the compress flag and the global load path.
    def defaults
      { :compress => self.compress?, :paths => self.paths }
    end

    # Returns a Hash with the debug options to pass to
    # Stylus.
    def debug_options
      { :linenos => self.debug?, :firebug => self.debug? }
    end

    # Return the gem version alongside with the current `Stylus` version of your system.
    def version
      "Stylus - gem #{VERSION} library #{exec('version')}"
    end

    protected
    def bundled_path
      File.dirname(Stylus::Source.bundled_path)
    end
  end

  # Exports the `.node_modules` folder on the working directory so npm can
  # require modules installed locally.
  ENV['NODE_PATH'] = [
    File.expand_path('node_modules'),
    File.expand_path('vendor/node_modules'),
    bundled_path,
    ENV['NODE_PATH']
  ].join(File::PATH_SEPARATOR)
end
