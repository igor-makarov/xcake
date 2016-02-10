require "spec_helper"

module Xcake
  describe DependencyProvider do
    context "when created" do
      before :each do
        @repository = double("Repository")
        @dependency = double("Dependency")
        @provider = DependencyProvider.new(@repository)
      end

      it "should set the repository" do
        expect(@provider.repository).to eq(@repository)
      end

      it "should return name for dependency" do
        name = @provider.name_for(@dependency)
        expect(name).to eq(@dependency)
      end

      it "should return dependency" do
        allow(@repository).to receive(:select).and_return(@dependency)
        result = @provider.search_for(@dependency)
        expect(result).to eq(@dependency)
      end

      it "should provide dependencies for specification" do
        specification = double("Specification")
        dependencies = []
        allow(specification).to receive(:dependencies).and_return(dependencies)

        result = @provider.dependencies_for(specification)
        expect(result).to eq(dependencies)
      end
    end
  end
end
