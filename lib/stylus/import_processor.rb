# Based on the ImportProcessor from the less-rails gem, by @metaskills
module Stylus
  class ImportProcessor < Tilt::Template

    IMPORT_SCANNER = /@import\s*['"]([^'"]+)['"]\s*/.freeze

    def prepare
    end

    def evaluate(context, locals, &block)
      dependencies = data.scan(IMPORT_SCANNER).flatten.compact.uniq

      dependencies.each do |path|
        asset = context.environment[path]
        if asset
          context.depend_on_asset(asset.pathname)
        end
      end
      data
    end
  end
end