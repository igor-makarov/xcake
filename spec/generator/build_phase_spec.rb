require 'spec_helper'

module Xcake
  module Generator
    describe BuildPhase do

      it "should be able to install file reference" do
        file_reference = double()
        expect(BuildPhase.can_install_file_reference(file_reference)).to be(true)
      end

      it "should store the file reference" do
        file_reference = double()
        build_phase = BuildPhase.new(file_reference)

        expect(build_phase.file_reference).to eq(file_reference)
      end
    end
  end
end
