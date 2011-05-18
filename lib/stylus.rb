require 'execjs'
require 'stylus/version'
require 'stylus/railtie' if defined?(::Rails)

module Stylus

  class << self
    @@compress = false

    def compress
      @@compress
    end

    def compress=(val)
      @@compress = val
    end

    def compile(source, options = {})
      source = source.read if source.respond_to?(:read)
      options = defaults.merge(options)
      context.call('compiler', source, options)
    end

    def defaults
      {:compress => self.compress }
    end

    def version
      "Stylus - gem #{VERSION} library #{context.call('version')}"
    end

    protected
    def context
      @@_context ||= backend.compile(script)
    end

    def script
      path = File.expand_path(File.dirname(__FILE__))
      File.read(File.join(path, 'stylus', 'compiler.js'))
    end

    def backend
      # Targeting the Runtime directly so we don't mess with other
      # gems using ExecJS.
      @@_backend ||= ExecJS::Runtimes::Node
    end
  end
end
