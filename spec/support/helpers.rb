module Helpers
  def create_routes
    destination = File.join(destination_root, "config")

    FileUtils.mkdir_p(destination)
    FileUtils.touch File.join(destination, 'routes.rb')
  end

  def create_app(options = {})
    Rails.application = nil

    Class.new(Rails::Application).tap do |app|
      assets = app.config.assets
      assets.cache_store = :memory_store
      assets.enabled  = options.fetch(:enabled, true)
      assets.compress = true if options[:compress]
      assets.debug    = true if options[:debug]
      assets.paths << fixture_root
      app.config.active_support.deprecation = :log
      app.initialize!
    end
  end

  def fixture_root
    File.expand_path('../../fixtures', __FILE__)
  end

  def output_root
    File.expand_path('../../cases', __FILE__)
  end

  def fixture(name)
    source = fixture_path(name)
    output = css_path(name)
    [source, output].map do |path|
      File.read(path) if File.file?(path)
    end
  end

  def css_path(name)
    File.join(output_root, "#{name}.css")
  end

  def fixture_path(name)
    File.join(fixture_root, "#{name}.styl")
  end
end
