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
end