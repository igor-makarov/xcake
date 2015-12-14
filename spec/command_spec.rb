require 'spec_helper'

module Xcake
  describe Command do
    it 'displays the current version number with the --version flag' do
      expect(Command.version).to eq(VERSION)
    end
  end
end
