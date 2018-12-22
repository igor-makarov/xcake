require 'spec_helper'

module Xcake
  describe Project do
    before :each do
      @project = Project.new
    end

    it 'should return the project' do
      expect(@project.project).to eq(@project)
    end

    context 'when creating application target' do
      before :each do
        @target = @project.application_for :ios, 8.0
      end

      it 'should store targets when created' do
        expect(@project.targets.count).to eq(1)
      end

      it 'should set type to application' do
        expect(@target.type).to eq(:application)
      end

      it 'should set platform' do
        expect(@target.platform).to eq(:ios)
      end

      it 'should set deployment target' do
        expect(@target.deployment_target).to eq(8.0)
      end

      it 'should default to objective c' do
        expect(@target.language).to eq(:objc)
      end

      context 'when specifying language' do
        before :each do
          @project = Project.new do |c|
            @target = c.application_for :ios, 8.0, :swift
          end
        end

        it 'should set language' do
          expect(@target.language).to eq(:swift)
        end
      end
    end

    context 'when creating ui test target' do
      before :each do
        @app_target = double('App Target')

        allow(@app_target).to receive(:name).and_return('application')
        allow(@app_target).to receive(:platform).and_return(:ios)
        allow(@app_target).to receive(:deployment_target).and_return(8.0)
        allow(@app_target).to receive(:language).and_return(:swift)
        allow(@app_target).to receive(:type).and_return(:application)

        @target = @project.ui_tests_for @app_target
      end

      it 'should prefix application name with "UITests"' do
        expect(@target.name).to eq('applicationUITests')
      end

      it 'should set type to ui test bundle' do
        expect(@target.type).to eq(:ui_test_bundle)
      end

      it 'should set platform to same as application target' do
        expect(@target.platform).to eq(:ios)
      end

      it 'should set deployment target to same as application target' do
        expect(@target.deployment_target).to eq(8.0)
      end

      it 'should set language to same as application target' do
        expect(@target.language).to eq(:swift)
      end

      it 'should not set TEST_HOST setting' do
        test_host_set = satisfy do |c|
          c.settings.key?('TEST_HOST') == false
        end
        expect(@target.all_configurations).to all(test_host_set)
      end

      it 'should not set BUNDLE_LOADER setting' do
        bundle_loader_set = satisfy do |c|
          c.settings.key?('BUNDLE_LOADER') == false
        end
        expect(@target.all_configurations).to all(bundle_loader_set)
      end

      it 'should set LD_RUNPATH_SEARCH_PATHS' do
        runpath_set = satisfy do |c|
          c.settings.key?('LD_RUNPATH_SEARCH_PATHS')
        end
        expect(@target.all_configurations).to all(runpath_set)
      end
    end

    context 'when creating unit test target' do
      before :each do
        @app_target = double('App Target')

        allow(@app_target).to receive(:name).and_return('application')
        allow(@app_target).to receive(:platform).and_return(:ios)
        allow(@app_target).to receive(:deployment_target).and_return(8.0)
        allow(@app_target).to receive(:language).and_return(:swift)
        allow(@app_target).to receive(:type).and_return(:application)

        @target = @project.unit_tests_for @app_target
      end

      it 'should prefix test target name with "Tests"' do
        expect(@target.name).to eq('applicationTests')
      end

      it 'should set type to unit test bundle' do
        expect(@target.type).to eq(:unit_test_bundle)
      end

      it 'should set platform to same as test target' do
        expect(@target.platform).to eq(:ios)
      end

      it 'should set deployment target to same as test target' do
        expect(@target.deployment_target).to eq(8.0)
      end

      it 'should set language to same as test target' do
        expect(@target.language).to eq(:swift)
      end

      it 'should set LD_RUNPATH_SEARCH_PATHS' do
        runpath_set = satisfy do |c|
          c.settings.key?('LD_RUNPATH_SEARCH_PATHS')
        end
        expect(@target.all_configurations).to all(runpath_set)
      end

      context 'for an application target' do
        it 'should set bundle loader setting to test host' do
          bundle_loader_set = satisfy do |c|
            c.settings['BUNDLE_LOADER'] == '$(TEST_HOST)'
          end
          expect(@target.all_configurations).to all(bundle_loader_set)
        end

        context 'on iOS' do
          it 'should set test host to application target executable' do
            executable_path = "$(BUILT_PRODUCTS_DIR)/#{@app_target.name}.app/#{@app_target.name}"
            test_host_set = satisfy do |c|
              c.settings['TEST_HOST'] == executable_path
            end
            expect(@target.all_configurations).to all(test_host_set)
          end
        end

        context 'on macOS' do
          before :each do
            allow(@app_target).to receive(:platform).and_return(:osx)
            @mac_target = @project.unit_tests_for @app_target
          end

          it 'should set test host to application target executable' do
            executable_path = "$(BUILT_PRODUCTS_DIR)/#{@app_target.name}.app/Contents/MacOS/#{@app_target.name}"
            test_host_set = satisfy do |c|
              c.settings['TEST_HOST'] == executable_path
            end
            expect(@mac_target.all_configurations).to all(test_host_set)
          end
        end
      end

      context 'for a non-application target' do
        before :each do
          allow(@app_target).to receive(:type).and_return(:library)

          @target = @project.unit_tests_for @app_target
        end

        it 'should not set test host to application target executable' do
          executable_path = "$(BUILT_PRODUCTS_DIR)/#{@app_target.name}.app/#{@app_target.name}"
          test_host_set = satisfy do |c|
            c.settings['TEST_HOST'] != executable_path
          end
          expect(@target.all_configurations).to all(test_host_set)
        end

        it 'should not set bundle loader setting to test host' do
          bundle_loader_set = satisfy do |c|
            c.settings['BUNDLE_LOADER'] != '$(TEST_HOST)'
          end
          expect(@target.all_configurations).to all(bundle_loader_set)
        end
      end
    end

    context 'when creating extension target' do
      before :each do
        @app_target = double('App Target')
        @dependencies = []

        allow(@app_target).to receive(:target_dependencies).and_return(@dependencies)
        allow(@app_target).to receive(:platform).and_return(:ios)
        allow(@app_target).to receive(:deployment_target).and_return(8.0)
        allow(@app_target).to receive(:language).and_return(:swift)
        allow(@app_target).to receive(:type)

        @target = @project.extension_for @app_target
      end

      it 'should set type to app extension' do
        expect(@target.type).to eq(:app_extension)
      end

      it 'should set platform to same as application target' do
        expect(@target.platform).to eq(:ios)
      end

      it 'should set deployment target to same as application target' do
        expect(@target.deployment_target).to eq(8.0)
      end

      it 'should set language to same as application target' do
        expect(@target.language).to eq(:swift)
      end
    end

    context 'when creating watch target' do
      before :each do
        @app_target = double('App Target').as_null_object
        @dependencies = []

        allow(@app_target).to receive(:name).and_return('application')
        allow(@app_target).to receive(:target_dependencies).and_return(@dependencies)

        @project.watch_app_for @app_target, 2.0, :swift do |app, extension|
          @watch_app_target = app
          @extension_target = extension
        end
      end

      context 'for host app' do
        it 'should add watch app as a dependency' do
          expect(@dependencies).to include(@watch_app_target)
        end
      end

      context 'for watch app' do
        it 'should add watch extension as a dependency' do
          expect(@watch_app_target.target_dependencies).to include(@extension_target)
        end

        it 'should prefix application name with "-Watch"' do
          expect(@watch_app_target.name).to eq('application-Watch')
        end

        it 'should set type' do
          expect(@watch_app_target.type).to eq(:watch2_app)
        end

        it 'should set platform' do
          expect(@watch_app_target.platform).to eq(:watchos)
        end

        it 'should set deployment target' do
          expect(@watch_app_target.deployment_target).to eq(2.0)
        end

        it 'should set language' do
          expect(@watch_app_target.language).to eq(:swift)
        end
      end

      context 'for watch extension' do
        it 'should prefix application name with "-Watch Extension"' do
          expect(@extension_target.name).to eq('application-Watch Extension')
        end

        it 'should set type' do
          expect(@extension_target.type).to eq(:watch2_extension)
        end

        it 'should set platform' do
          expect(@extension_target.platform).to eq(:watchos)
        end

        it 'should set language' do
          expect(@extension_target.language).to eq(:swift)
        end
      end
    end
  end
end
