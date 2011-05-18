require 'spec_helper'

describe Stylus do
  it "compiles the given source" do
    input, output = fixture :simple
    Stylus.compile(input).should == output
  end

  it "compress the file when the compress flag is given" do
    input, output = fixture :compressed
    Stylus.compile(input, 'compress' => true).should == output
  end
end