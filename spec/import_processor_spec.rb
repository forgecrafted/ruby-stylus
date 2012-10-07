require 'spec_helper'

describe Stylus::ImportProcessor do
  it 'adds an imported stylesheet as a dependency' do
    source     = fixture(:import).first
    template   = Stylus::ImportProcessor.new { source }
    dependency = Pathname.new(fixture_path('mixins/vendor'))
    sprockets  = double(:resolve => dependency)

    sprockets.should_receive(:depend_on).with(dependency)
    template.render(sprockets)
  end

  it 'walks the dependency chain of imported files' do
    source    = fixture(:nested_import).first
    template  = Stylus::ImportProcessor.new { source }
    nested    = Pathname.new(fixture_path('mixins/nested'))
    vendor    = Pathname.new(fixture_path('mixins/vendor'))
    sprockets = double

    sprockets.should_receive(:resolve).with('mixins/nested', :content_type=>"text/css") { nested }
    sprockets.should_receive(:resolve).with('mixins/vendor', :content_type=>"text/css") { vendor }
    sprockets.should_receive(:depend_on).with(nested)
    sprockets.should_receive(:depend_on).with(vendor)

    template.render(sprockets)
  end

  it "swallows errors from files outside the Sprockets paths" do
    source = "@import 'nib'"
    template = Stylus::ImportProcessor.new { source }
    sprockets = double()
    sprockets.should_receive(:resolve).and_raise(::Sprockets::FileNotFound)

    expect {
      template.render(sprockets)
    }.to_not raise_error(::Sprockets::FileNotFound)
  end
end