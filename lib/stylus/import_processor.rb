# Based on the ImportProcessor from the less-rails gem, by @metaskills
module Stylus
  # Internal: A Tilt template that tracks down '@import' declarations
  # and marks them as a dependency on the current asset.
  #
  # Example
  #
  #  @import 'dashboard'
  #  # => A '//= depend_on dashboard' directive can be ommited from the stylesheet.
  class ImportProcessor < Tilt::Template

    IMPORT_SCANNER = /@import\s*['"]([^'"]+)['"]\s*/.freeze

    # Internal: Tilt default interface requirement.
    #
    # Returns nothing.
    def prepare
    end

    # Internal: Scan the stylesheet body, looking for '@import' calls to
    # declare them as dependency on the context using 'depend_on' method.
    def evaluate(context, locals, &block)
      dependencies = data.scan(IMPORT_SCANNER).flatten.compact.uniq

      dependencies.each do |path|
        asset = resolve(context, path)

        if asset
          context.depend_on(asset)
        end
      end
      data
    end

    # Internal: Resolves the given 'path' with the Sprockets context, but
    # avoids 'Sprockets::FileNotFound' exceptions since we might be importing
    # files outside the Sprockets load path - like "nib".
    #
    # Returns the resolved 'Asset' or nil if it can't be found.
    def resolve(context, path)
      context.resolve(path, :content_type => 'text/css')
    rescue ::Sprockets::FileNotFound
      nil
    end
  end
end