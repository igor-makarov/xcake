require 'spec_helper'

describe String do
  it 'should escape Objective-C string' do
    expect('Hey'.to_obj_c).to eq('\\@\\"Hey\\"')
  end

  it 'should escape C string' do
    expect('Hey'.to_c).to eq('\\"Hey\\"')
  end

  it 'should string heredoc indentation' do
    heredoc = <<-SCRIPT
    Hey
    SCRIPT

    expect(heredoc).to eq("    Hey\n")
  end
end
