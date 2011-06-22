require 'execjs'
require 'stylus/version'
require 'stylus/railtie' if defined?(::Rails)

module Stylus

  class << self
    @@compress = false
    @@paths = []
    @@plugins = {}

    def use(*options)
      arguments = options.last.is_a?(Hash) ? options.pop : {}
      options.each do |plugin|
        @@plugins[plugin] = arguments
      end
    end
    alias :plugin :use

    def plugins
      @@plugins
    end

    def paths
      @@paths
    end

    def paths=(val)
      @@paths = Array(val)
    end

    def compress
      @@compress
    end

    def compress=(val)
      @@compress = val
    end

    def compile(source, options = {})
      source = source.read if source.respond_to?(:read)
      options = merge_options(options)
      context.call('compiler', source, options, plugins)
    end

    def convert(source)
      source = source.read if source.respond_to?(:read)
      context.call('convert', source)
    end

    def merge_options(options)
      _paths = options.delete(:paths)
      options = defaults.merge(options)
      options[:paths] = paths.concat(Array(_paths))
      options
    end

    def defaults
      { :compress => self.compress, :paths => self.paths }
    end

    def version
      "Stylus - gem #{VERSION} library #{context.call('version')}"
    end

    protected
    def context
      @@_context ||= backend.compile(script)
    end

    def script
      File.read(File.expand_path('../stylus/compiler.js',__FILE__))
    end

    def backend
      # Targeting the Runtime directly so we don't mess with other
      # gems using ExecJS.
      @@_backend ||= ExecJS::Runtimes::Node
    end
  end
end
