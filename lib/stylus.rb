require 'execjs'

begin
  require 'tilt'
  require 'stylus/tilt'
  Tilt.register Tilt::StylusTemplate, 'styl'
rescue LoadError
end

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
      options = defaults.merge(options)
      context.call('compiler', source, options)
    end

    def defaults
      {:compress => self.compress }
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
