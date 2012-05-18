require 'spec_helper'

describe Stylus::Runtime do
  it "raises an error if the runtime isn't available" do
    Stylus.stub(:runtime) { mock("An unavailable Runtime", :available? => false) }

    expect {
      Stylus.version
    }.to raise_error RuntimeError, %r[The Node.JS runtime isn't available to Stylus.]
  end
end