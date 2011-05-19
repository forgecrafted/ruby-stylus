require 'tilt'
require 'tilt/template'

module Tilt
  # Stylus template implementation. See:
  # http://learnboost.github.com/stylus/
  #
  # Stylus templates do not support object scopes, locals, or yield.
  class StylusTemplate < Template
    self.default_mime_type = 'text/css'

    def prepare
    end

    def evaluate(scope, locals, &block)
      Stylus.compile(data, options)
    end
  end
end

Tilt.register Tilt::StylusTemplate, 'styl'