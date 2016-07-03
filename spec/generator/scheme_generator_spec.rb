require 'spec_helper'

module Xcake
  describe SchemeGenerator do
    before :each do
      @dsl_project = double('DSL Project')
      @project = double('Project')

      @context = double('Context')
      allow(@context).to receive(:native_object_for).and_return(@project)

      @generator = SchemeGenerator.new(@context)
    end

    it 'should rhave correct dependencies' do
      expect(SchemeGenerator.dependencies).to eq([TargetGenerator, ConfigurationGenerator])
    end

    it 'should recreate user schemes' do
      expect(@project).to receive(:recreate_user_schemes)
      @generator.visit_project(@dsl_project)
    end
  end
end
