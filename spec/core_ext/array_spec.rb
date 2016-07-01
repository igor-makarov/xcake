require "spec_helper"

describe Array do
  it "should convert to hash" do
    expect(["key", "value"].to_h).to eq({ "key" => "value" })
  end
end
