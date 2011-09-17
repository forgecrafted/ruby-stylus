module Helpers
  def create_routes
    destination = File.join(destination_root, "config")

    FileUtils.mkdir_p(destination)
    FileUtils.touch File.join(destination, 'routes.rb')
  end

  def create_app(options = {})
    Rails.application = nil
    Class.new(Rails::Application).tap do |app|
      app.config.assets.enabled = true
      app.config.assets.compress = true if options[:compress]
      app.config.assets.paths << fixture_root
      app.config.active_support.deprecation = :log
      app.initialize!
    end
  end

  def fixture_root
    File.expand_path('../../fixtures', __FILE__)
  end

  def fixture(name)
    %w[.styl .css].map do |format|
      path = fixture_path(name, format)
      File.read(path) if File.file?(path)
    end
  end

  def fixture_path(name, format = ".styl")
    filename = name.to_s + format
    File.join(fixture_root, filename)
  end
end
