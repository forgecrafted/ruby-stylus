require 'spec_helper'

describe Stylus do

  it "compiles the given source" do
    input, output = fixture :simple
    Stylus.compile(input).should == output
  end

  it "accepts a IO object as source" do
    input, output = fixture :simple
    input = StringIO.new(input)
    Stylus.compile(input).should == output
  end

  it "compress the file when the compress flag is given" do
    input, output = fixture :compressed
    Stylus.compile(input, :compress => true).should == output
  end

  it "uses the class level compress flag" do
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
    input, output = fixture :nib
    Stylus.compile(input).should == output
  end
end