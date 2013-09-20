require 'tilt'
# Public: A Tilt template to compile Stylus stylesheets.
#
# Examples
#
#  template = Tilt::StylusTemplate.new { |t| File.read('app.styl') }
#  template.render
#  # => the compiled CSS from the app.styl file.
#
#  Options should assigned on the template constructor.
#  template = Tilt::StylusTemplate.new(:compress => true) { |t| File.read('app.styl') }
#  template.render
#  # => the compiled CSS with compression enabled.
module Tilt
  class StylusTemplate < Template

    # Public: The default mime type for stylesheets.
    self.default_mime_type = 'text/css'

    # Internal: Checks if the Stylus module has been properly defined.
    #
    # Returns true if the 'Stylus' module is present.
    def self.engine_initialized?
      defined? ::Stylus
    end

    # Internal: Require the 'stylus' file to load the Stylus module.
    #
    # Returns nothing.
    def initialize_engine
      require_template_library 'stylus'
    end

    # Internal: Caches the filename as an option entry if it's present.
    #
    # Returns nothing.
    def prepare
      if self.file
        options[:filename] ||= self.file
      end
    end

    # Internal: Compile the template Stylus using this instance options.
    # The current 'scope' and given 'locals' are ignored and the output
    # is cached.
    #
    # Returns the compiled stylesheet with CSS syntax.
    def evaluate(scope, locals, &block)
      data = Stylus::Helpers::AssetMixin.prepend_import_directive(scope, self.data)
      @output ||= Stylus.compile(data, options)
    end
  end
end

Tilt.register Tilt::StylusTemplate, 'styl'