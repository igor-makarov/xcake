require 'spec_helper'

module Xcake
  module Generator
    describe BuildConfiguration do
      it 'stores the build configuration' do
        build_configuration = Xcake::BuildConfiguration.new("Configuration")
        generator = BuildConfiguration.new(build_configuration)

        expect(generator.build_configuration).to eq(build_configuration)
      end
    end
  end
end
