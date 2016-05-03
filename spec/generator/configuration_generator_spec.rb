require "spec_helper"

module Xcake
  describe ConfigurationGenerator do
    before :each do
      @native_configuration = double("Xcode Configuration").as_null_object
      @native_configurable = double("Xcode Configurable").as_null_object
      @context = double("Context")

      @generator = ConfigurationGenerator.new(@context)
    end

    it "should have correct dependencies" do
      expect(ConfigurationGenerator.dependencies).to eq([TargetGenerator, ProjectStructureGenerator])
    end

    context "when visiting project" do
      it "it should create build configurations" do
        project = double("Project")
        expect(@generator).to receive(:create_build_configurations_for).with(project)
        @generator.visit_project(project)
      end
    end

    context "when visiting target" do
      it "it should create build configurations" do
        target = double("Target")
        expect(@generator).to receive(:create_build_configurations_for).with(target)
        @generator.visit_target(target)
      end
    end

    context "when creating configuration for configurable" do
      before :each do
        @configuration = double("Configuration")
        allow(@configuration).to receive(:name).and_return("Name")
        allow(@configuration).to receive(:settings).and_return({})
        allow(@configuration).to receive(:configuration_file).and_return("File.xcconfig")

        @configurable = double("Configurable")
        allow(@configurable).to receive(:all_configurations).
          and_return([@configuration])

        @node = double("Node").as_null_object
        allow(@node).to receive(:new).and_return(@configuration.configuration_file)
        allow(Node).to receive(:new).and_return(@node)

        @native_group = double("Native Group").as_null_object

        allow(@context).to receive(:native_object_for).with(@node).and_return(@native_group)
        allow(@context).to receive(:native_object_for).with(@configuration).and_return(@native_configuration)
        allow(@context).to receive(:native_object_for).with(@configurable).and_return(@native_configurable)
      end

      it "should create a new Configuration" do
        expect(@context).to receive(:native_object_for).with(@configuration)
        @generator.create_build_configurations_for(@configurable)
      end

      context "when installing XCConfig" do

        it "should set node path" do
          expect(@node).to receive(:path=).with(@configuration.configuration_file)
          @generator.create_build_configurations_for(@configurable)
        end

        it "should add XCConfig File to the project" do
          expect(@native_group).to receive(:new_reference).with(@node.path)
          @generator.create_build_configurations_for(@configurable)
        end

        it "should set XCConfig for configurable" do
          xcconfig = double("XCConfig File Reference")

          allow(@native_group).to receive(:new_reference).and_return(xcconfig)
          expect(@native_configurable).to receive(:base_configuration_reference=).with(xcconfig)

          @generator.create_build_configurations_for(@configurable)
        end
      end

      context "when configuring Configuration" do
        it "should set name" do
          expect(@native_configuration).to receive(:name=).with(@configuration.name)
          @generator.create_build_configurations_for(@configurable)
        end

        it "should set settings" do
          expect(@native_configuration).to receive(:build_settings=).with(@configuration.settings)
          @generator.create_build_configurations_for(@configurable)
        end

        it 'should store it in it\'s targets build configurations' do
          build_configurations = double("Build Configurations")
          allow(@native_configurable).to receive(:build_configurations).and_return(build_configurations)

          expect(build_configurations).to receive(:<<).with(@native_configuration)
          @generator.create_build_configurations_for(@configurable)
        end
      end
    end
  end
end
