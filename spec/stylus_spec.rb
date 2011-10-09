require 'stylus'
require 'spec_helper'

describe Stylus do

  it "compiles the given source" do
    input, output = fixture :simple
    Stylus.compile(input).should == output
  end

  it "accepts an IO object" do
    input, output = fixture :simple
    input = StringIO.new(input)
    Stylus.compile(input).should == output
  end

  it "compress the file when the 'compress' flag is given" do
    input, output = fixture :compressed
    Stylus.compile(input, :compress => true).should == output
  end

  it "handles the compress flag globally" do
    Stylus.compress = true
    input, output = fixture :compressed
    Stylus.compile(input).should == output
  end

  it "imports the given paths" do
    path = fixture_root
    input, output = fixture :import
    Stylus.compile(input, :paths => path).should == output
  end

  it "handles the import paths globally" do
    Stylus.paths << fixture_root
    input, output = fixture :import
    Stylus.compile(input).should == output
  end

  it 'implicit imports the given paths' do
    path = File.expand_path('mixins/vendor.styl', fixture_root)
    input, output = fixture :implicit
    Stylus.import path
    Stylus.compile(input).should == output
  end

  it "outputs both gem and library version" do
    Stylus.version.should =~ /Stylus - gem .+ library .+/
  end

  it "converts CSS to Stylus" do
    stylus, css = fixture :stylesheet
    Stylus.convert(css).should == stylus
  end

  it "stores the given plugins" do
    Stylus.use :one, :two, :argument => true
    Stylus.should have(2).plugins
  end

  it "includes the given plugins" do
    Stylus.use :nib
    input, output = fixture :plugin
    Stylus.compile(input).should == output
  end

  it "includes and imports 'nib' automatically" do
    Stylus.nib = true
    input, output = fixture :nib
    Stylus.compile(input).should == output
  end

  describe "The debug flag" do

    let(:path) { fixture_path(:debug) }
    let(:fixture) { File.read(path) }
    let(:file) { File.new(path) }

    before { Stylus.debug = true }

    it "turns the 'linenos' option on" do
      Stylus.compile(file).should match(/line 1 : #{path}/)
    end

    it "skips the 'linenos' option if no filename is given" do
      Stylus.compile(fixture).should_not match(/line 1 : #{path}/)
    end

    it "turns the 'firebug' option on" do
      Stylus.compile(file).should match(/@media -stylus-debug-info/)
    end

    it "skips the 'firebug' option if no filename is given" do
      Stylus.compile(fixture).should_not match(/@media -stylus-debug-info/)
    end
  end
end