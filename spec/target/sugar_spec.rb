require 'spec_helper'

module Xcake
  describe Target do
    before :each do
      project = double('Project').as_null_object
      @target = Target.new(project)
    end

    context 'when adding a copy headers build phase with a string' do
        before :each do
          @phase = @target.shell_script_build_phase('Hello World', <<-SCRIPT)
            echo hello world
          SCRIPT
        end

        it 'should add the build phase' do
          expect(@target.build_phases.length).to eq(1)
        end

        it 'should truncate the preceding whitespace' do
          expect(@phase.script).not_to match(/^[ \t]/)
        end
    end

    context 'when adding a link library build phase with a string' do
        before :each do
          @phase = @target.shell_script_build_phase('Hello World', <<-SCRIPT)
            echo hello world
          SCRIPT
        end

        it 'should add the build phase' do
          expect(@target.build_phases.length).to eq(1)
        end

        it 'should truncate the preceding whitespace' do
          expect(@phase.script).not_to match(/^[ \t]/)
        end
    end

    context 'when adding a shell script build phase with a string' do
      before :each do
        @phase = @target.shell_script_build_phase('Hello World', <<-SCRIPT)
          echo hello world
        SCRIPT
      end

      it 'should add the build phase' do
        expect(@target.build_phases.length).to eq(1)
      end

      it 'should truncate the preceding whitespace' do
        expect(@phase.script).not_to match(/^[ \t]/)
      end
    end
  end
end
