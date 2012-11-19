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

    # Public: Scans the current stylesheet to track down Stylus
    # '@import' calls as dependencies.
    #
    # Returns the stylesheet content, unmodified.
    def evaluate(context, locals, &block)
      depend_on(context, data)
      data
    end

    private

    # Internal: Scan the stylesheet body, looking for '@import' calls to
    # declare them as a dependency on the context using 'depend_on' method.
    # This method will recursively scans all dependency to ensure that
    # the current stylesheet tracks down nested dependencies.
    def depend_on(context, data)
      dependencies = data.scan(IMPORT_SCANNER).flatten.compact.uniq

      dependencies.each do |path|
        asset = resolve(context, path)

        if asset
          context.depend_on(asset)
          depend_on(context, File.read(asset))
        end
      end
    end

    # Internal: Resolves the given 'path' with the Sprockets context, but
    # avoids 'Sprockets::FileNotFound' exceptions since we might be importing
    # files outside the Sprockets load path - like "nib".
    #
    # Returns the resolved 'Asset' or nil if it can't be found.
    def resolve(context, path)
      context.resolve(path, :content_type => 'text/css')
    rescue ::Sprockets::FileNotFound
      begin
        context.resolve(path + '/index', :content_type => 'text/css')
      rescue
        nil
      end
    end
  end
end
