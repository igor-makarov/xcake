require "spec_helper"

describe String do
  it "should escape Objective-C string" do
    expect("Hey".to_obj_c).to eq("\\\@\\\"Hey\\\"")
  end

  it "should escape C string" do
    expect("Hey".to_c).to eq("\\\"Hey\\\"")
  end

#   it "should provide dependencies for specification" do
#   end
end
