require 'spec_helper'

module Xcake
  describe FileReferenceInstaller do
    context 'when created' do
      before :each do
        @context = double('Context')
        @installer = FileReferenceInstaller.new(@context)
      end

      it 'should set the context' do
        expect(@installer.context).to eq(@context)
      end

      it 'should be able to install node' do
        node = double('Node')
        can_install = FileReferenceInstaller.can_install_node(node)
        expect(can_install).to be true
      end
    end
  end
end
