require "test_helper"

describe Taco do
  let(:taco) { Taco.new }

  it "must be valid" do
    value(taco).must_be :valid?
  end
end
