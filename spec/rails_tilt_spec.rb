require 'spec_helper'
require 'stylus/rails_tilt'

describe Stylus::Rails::StylusTemplate do

  it "registers the template for .styl files" do
    Tilt['application.styl'].should == Stylus::Rails::StylusTemplate
  end

  it "has a content-type" do
    Stylus::Rails::StylusTemplate.default_mime_type.should == 'text/css'
  end

  context "when no resources other then css found" do
    it "compiles the given source without changes" do
      result = fixture(:simple).last

      app = create_app
      app.assets['simple'].to_s.should == result
    end
  end


  it "substitutes asset_path with path" do
    app = create_app do |app|
      app.config.assets.paths << images_root
      app.config.asset_host = 'http://localhost'
    end
    result = fixture(:asset_path).last
    app.assets['asset_path'].to_s.should == result
  end

  it "substitutes asset_url with url" do
    app = create_app do |app|
      app.config.assets.paths << images_root
      app.config.asset_host = 'http://localhost'
    end
    result = fixture(:asset_url).last
    app.assets['asset_url'].to_s.should == result
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
      digested_image_path.should match(/^rails-(\w+)\.png$/)
      app.assets['digested_asset_path'].to_s.should == "body {\n  background-image: url(\"http://localhost/assets/#{digested_image_path}\");\n}\n"
    end

    it 'appends fingerprint to asset url' do
      digested_image_path = app.assets['rails.png'].digest_path
      digested_image_path.should match(/^rails-(\w+)\.png$/)
      app.assets['digested_asset_url'].to_s.should == "body {\n  background-image: url(\"http://localhost/assets/#{digested_image_path}\");\n}\n"
    end
  end

end