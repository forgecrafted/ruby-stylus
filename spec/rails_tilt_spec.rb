require 'spec_helper'
require 'stylus/rails_tilt'

describe Stylus::Rails::StylusTemplate do
  it 'registers the template for .styl files' do
    expect(Tilt['application.styl']).to eq(Stylus::Rails::StylusTemplate)
  end

  it 'has a content-type' do
    expect(Stylus::Rails::StylusTemplate.default_mime_type).to eq('text/css')
  end

  context 'when no resources other then css found' do
    it 'compiles the given source without changes' do
      result = fixture(:simple).last

      app = create_app
      expect(app.assets['simple'].to_s).to eq(result)
    end
  end


  it 'substitutes asset_path with path' do
    app = create_app do |app|
      app.config.assets.paths << images_root
      app.config.asset_host = 'http://localhost'
    end
    result = fixture(:asset_path).last
    expect(app.assets['asset_path'].to_s).to eq(result)
  end

  it 'substitutes asset_url with url' do
    app = create_app do |app|
      app.config.assets.paths << images_root
      app.config.asset_host = 'http://localhost'
    end
    result = fixture(:asset_url).last
    expect(app.assets['asset_url'].to_s).to eq(result)
  end

  context 'when config.assets.digest = true' do
    let(:app) do
      create_app do |app|
        app.config.assets.paths << images_root
        app.config.asset_host = 'http://localhost'
        app.config.assets.digest = true
      end
    end

    it 'appends fingerprint to asset path' do
      digested_image_path = app.assets['rails.png'].digest_path
      expect(digested_image_path).to match(/^rails-(\w+)\.png$/)
      asset = app.assets['digested_asset_path']
      expect(asset.to_s).to eq("body {\n  background-image: url(\"http://localhost/assets/#{digested_image_path}\");\n}\n")
    end

    it 'appends fingerprint to asset url' do
      digested_image_path = app.assets['rails.png'].digest_path
      expect(digested_image_path).to match(/^rails-(\w+)\.png$/)
      asset = app.assets['digested_asset_url']
      expect(asset.to_s).to eq("body {\n  background-image: url(\"http://localhost/assets/#{digested_image_path}\");\n}\n")
    end
  end
end
