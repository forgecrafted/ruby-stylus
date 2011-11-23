# See https://github.com/metaskills/less-rails/blob/b247f24239b2b2fdb6816c4833e43086a1ae9933/lib/less/rails/import_processor.rb
module Stylus
  class ImportProcessor < Tilt::Template

    IMPORT_SCANNER = /@import\s*['"]([^'"]+)['"]\s*;/.freeze

     def prepare
     end

     def evaluate(context, locals, &block)
       import_paths = data.scan(IMPORT_SCANNER).flatten.compact.uniq
       import_paths.each do |path|
         asset = context.environment[path]
         if asset && asset.pathname.to_s.ends_with?('.styl')
           context.depend_on_asset(asset.pathname)
         end
       end
       data
     end
  end
end