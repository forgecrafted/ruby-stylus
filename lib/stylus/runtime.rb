require 'execjs'

module Stylus
  module Runtime
    def exec(*arguments)
      context.call(*arguments)
    end

    private
    # Returns the `ExecJS` execution context.
    def context
      @context ||= backend.compile(script)
    end

    # Reads the default compiler script that `ExecJS` will execute.
    def script
      File.read(File.expand_path('../runtime/compiler.js',__FILE__))
    end

    # `ExecJS` 1.2.5+ doesn't support `require` statements on node anymore,
    # so we use a new instance of the `ExternalRuntime` with the old runner script.
    def backend
      @backend ||= ExecJS::ExternalRuntime.new(
        :name        => 'Node.js (V8)',
        :command     => ["nodejs", "node"],
        :runner_path => File.expand_path("../runtime/runner.js", __FILE__)
        )
    end
  end
end