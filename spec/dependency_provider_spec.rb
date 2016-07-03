require 'spec_helper'

module Xcake
  describe DependencyProvider do
    context 'when created' do
      it 'should provide dependencies' do
        dependency_a = double('Dependency A')
        dependency_b = double('Dependency B')
        allow(dependency_a).to receive(:dependencies).and_return([dependency_b])
        allow(dependency_b).to receive(:dependencies).and_return([])

        plugin = double('Plugin')
        allow(plugin).to receive(:load_plugins).and_return([
                                                             dependency_a, dependency_b
                                                           ])

        provider = DependencyProvider.new(plugin)
        dependencies = provider.tsort

        expect(dependencies).to eq([
                                     dependency_b,
                                     dependency_a
                                   ])
      end
    end
  end
end
