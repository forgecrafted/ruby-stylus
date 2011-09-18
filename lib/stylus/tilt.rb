require 'tilt'

module Tilt
  ### Stylus template implementation for `Tilt`.
  #
  # It can be used by the `Rails` Asset Pipeline or `Sinatra` applications.
  class StylusTemplate < Template
    self.default_mime_type = 'text/css'

    def self.engine_initialized?
      defined? ::Stylus
    end

    def prepare
      require_template_library 'stylus'
    end

    def evaluate(scope, locals, &block)
      if scope.respond_to?(:pathname)
        options[:filename] ||= scope.pathname.to_s
      end
      Stylus.compile(data, options)
    end
  end
end

Tilt.register Tilt::StylusTemplate, 'styl'