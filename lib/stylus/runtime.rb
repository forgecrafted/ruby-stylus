require 'execjs'

module Stylus
  # Internal: Module responsible for the ExecJS interaction.
  module Runtime
    # Internal: Calls a specific function on the Node.JS context.
    #
    # Example
    #  exec('String.prototype.toString', 2)
    #  # => "2"
    #
    # Returns The function returned value.
    def exec(*arguments)
      context.call(*arguments)
    end

    private
    # Internal: Compile the Stylus compilation script into a execution context
    # to execute functions into.
    #
    # Returns the compiled context.
    def context
      @context ||= backend.compile(script)
    end

    # Internal: The custom compilation script body.
    def script
      File.read(File.expand_path('../runtime/compiler.js',__FILE__))
    end

    # Internal: Create the ExecJS external runtime with a old runner script that
    # maintains the state of 'require', so we can use it to load modules like on
    # any Node.JS program.
    def backend
      @backend ||= ExecJS::ExternalRuntime.new(
        :name        => 'Node.js (V8)',
        :command     => ["nodejs", "node"],
        :runner_path => File.expand_path("../runtime/runner.js", __FILE__)
        )
    end
  end
end