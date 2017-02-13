require "spec_helper"

describe Sinatra::Rider do
  it "has a version number" do
    expect(Sinatra::Rider::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
