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

  context "nested" do
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

    it "adds files referenced in a directory's index file" do
      source     = fixture(:indexed_nested_import).first
      template   = Stylus::ImportProcessor.new { source }
      index      = Pathname.new(fixture_path('indexed/index'))
      first_dep  = Pathname.new(fixture_path('indexed/first_dep'))
      second_dep = Pathname.new(fixture_path('indexed/second_dep'))
      sprockets  = double

      sprockets.should_receive(:resolve).with('indexed', :content_type=>"text/css").and_raise(::Sprockets::FileNotFound)
      sprockets.should_receive(:resolve).with('indexed/index', :content_type=>"text/css") { index }
      sprockets.should_receive(:resolve).with('indexed/first_dep', :content_type=>"text/css") { first_dep }
      sprockets.should_receive(:resolve).with('indexed/second_dep', :content_type=>"text/css") { second_dep }
      sprockets.should_receive(:depend_on).with(index)
      sprockets.should_receive(:depend_on).with(first_dep)
      sprockets.should_receive(:depend_on).with(second_dep)

      template.render(sprockets)
    end

    it "walks dependency chains through indexes" do
      source     = fixture(:indexed_recursive_import).first
      template   = Stylus::ImportProcessor.new { source }
      nested     = Pathname.new(fixture_path('indexed_nested_import'))
      index      = Pathname.new(fixture_path('indexed/index'))
      first_dep  = Pathname.new(fixture_path('indexed/first_dep'))
      second_dep = Pathname.new(fixture_path('indexed/second_dep'))
      sprockets  = double

      sprockets.should_receive(:resolve).with('indexed_nested_import', :content_type=>'text/css') { nested }
      sprockets.should_receive(:resolve).with('indexed', :content_type=>"text/css").and_raise(::Sprockets::FileNotFound)
      sprockets.should_receive(:resolve).with('indexed/index', :content_type=>"text/css") { index }
      sprockets.should_receive(:resolve).with('indexed/first_dep', :content_type=>"text/css") { first_dep }
      sprockets.should_receive(:resolve).with('indexed/second_dep', :content_type=>"text/css") { second_dep }
      sprockets.should_receive(:depend_on).with(nested)
      sprockets.should_receive(:depend_on).with(index)
      sprockets.should_receive(:depend_on).with(first_dep)
      sprockets.should_receive(:depend_on).with(second_dep)

      template.render(sprockets)
    end
  end


  it "swallows errors from files outside the Sprockets paths" do
    source = "@import 'nib'"
    template = Stylus::ImportProcessor.new { source }
    sprockets = double()
    sprockets.should_receive(:resolve).twice.and_raise(::Sprockets::FileNotFound)

    expect {
      template.render(sprockets)
    }.to_not raise_error(::Sprockets::FileNotFound)
  end
end
