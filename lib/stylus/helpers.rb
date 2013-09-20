module Stylus
  module Helpers
    class AssetMixin
      attr_accessor :file

      def initialize(scope)
        @scope = scope
        @available_assets = []
        Rails.application.assets.each_logical_path {|asset| @available_assets << asset}
      end

      # Public: Creates stylus mixin, to include it before compiling stylus files.
      #
      # Returns instance of +Stylus::Helpers::AssetMixin+
      def self.create(scope)
        instance = self.new(scope)
        instance.create_file
        instance
      end

      # Public: Modifies data if modification allowed
      #
      # Returns modified data as string, or original data
      def self.prepend_import_directive(scope, data)
        modify? ? create(scope).prepend_import_directive(data) : data
      end

      # Public: Prepends data with style import directive to support "asset_path" and "asset_url"
      #
      # Returns String
      def prepend_import_directive(data)
        data.prepend(import_directive)
      end

      # Public: Generates stylus import directive
      #
      # Returns String
      def import_directive
        "@import '#{self.file.path}' \n"
      end

      # Internal: Creates a mixin file
      #
      # Returns nothing
      def create_file
        self.file = File.open(temp_file_path, 'w')
        self.file.write(mixin_body)
        self.file.close
      end

      def temp_file_path
        path = Rails.root.join('tmp', 'assets_mixin.styl')
        FileUtils.mkdir_p path.dirname
        path
      end

      # Internal: Builds body of a mixin
      #
      # Returns string representation of a mixin
      def mixin_body
        <<-STYL
asset-url(key)
  return pair[1] if pair[0] == key for pair in #{assets_hash}
asset-path(key)
  return pair[1] if pair[0] == key for pair in #{assets_hash(:relative => true)}
        STYL
      end

      # Internal: Construct Hash in stylus syntax, that consists of absolute and relative paths to assets
      #
      # Returns string representation of hash in Stylus syntax
      def assets_hash(options = {})
        assets = @available_assets.map do |logical_path|
          asset_path = resolve_path(logical_path, options) rescue nil
          asset_path ? %{("#{logical_path}" url('#{asset_path}'))} : nil
        end.compact
        assets << '()' if assets.count < 2
        assets.join(' ')
      end

      def resolve_path(path, options = {})
        if options[:relative]
          @scope.asset_path(path)
        else
          @scope.asset_url(path)
        end
      end

      # Internal: Checks if asset_mixin can be used
      #
      # Returns Bool
      def self.modify?
        defined?(Rails) && Rails.root.present?
      end

    end
  end
end