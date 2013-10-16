require 'spec_helper'

describe Stylus::Runtime do
  it 'raises an error if the runtime is not available' do
    allow(Stylus).to receive(:runtime) { double('An unavailable Runtime', available?: false) }

    expect {
      Stylus.version
    }.to raise_error RuntimeError, %r[The Node.JS runtime is not available to Stylus.]
  end
end
