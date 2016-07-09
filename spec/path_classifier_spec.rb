require 'spec_helper'

module Xcake
  describe PathClassifier do
    context 'when created' do
      before :each do
        @context = double('Context')
        @installer = PathClassifier.new
      end
    end
  end
end
