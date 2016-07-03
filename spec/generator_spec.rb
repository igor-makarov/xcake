require 'spec_helper'

module Xcake
  describe Generator do
    context 'when created' do
      before :each do
        @context = double('Context')
        @generator = Generator.new(@context)
      end

      it 'should set the context' do
        expect(@generator.context).to eq(@context)
      end
    end
  end
end
