require 'execjs'

module Stylus

  class << self
    def compile(source, options = {})
      context.call('compiler', source, options)
    end

    def context
      @@_context ||= backend.compile(script)
    end

    def script
      path = File.expand_path(File.dirname(__FILE__))
      File.read(File.join(path, 'stylus', 'compiler.js'))
    end

    def backend
      @@_backend ||= ExecJS::Runtimes::Node
    end
  end
end
