require 'tilt/template'

module Tilt
  class StylusTemplate < Template

    def prepare
    end

    def evaluate(scope, locals, &block)
      Stylus.compile(data, options)
    end
  end
end