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