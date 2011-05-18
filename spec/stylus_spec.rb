require 'stylus'

def fixture(name)
  path = File.dirname(File.expand_path(__FILE__))
  stylus = File.read(File.join(path, 'fixtures', "#{name}.styl"))
  css    = File.read(File.join(path, 'fixtures', "#{name}.css"))
  [stylus, css]
end

describe Stylus do
  describe ".compile" do
    it "compiles the given source" do
      input, output = fixture :simple
      Stylus.compile(input).should == output
    end

    it "compress the file when the compress flag is given" do
      input, output = fixture :compressed
      Stylus.compile(input, 'compress' => true).should == output
    end
  end
end