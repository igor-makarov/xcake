require 'spec_helper'

module Xcake
  module Generator
    describe Target do

      before :each do
        @project = double()
        @root_node = double()

        @generator = Target.new(@project, @root_node)
      end

      it 'run build configuration generator when visiting build configuration' do
        build_configuration_generator = double()
        allow(BuildConfiguration).to receive(:new).and_return(build_configuration_generator)

        build_configuration = double()
        expect(build_configuration).to receive(:accept).with(build_configuration_generator)

        @generator.visit_buildconfiguration(build_configuration)
      end
    end
  end
end
