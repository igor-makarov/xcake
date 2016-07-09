require 'spec_helper'

module Xcake
  describe PathClassifier do
    context 'when created' do
      before :each do
        @context = double('Context')
        @installer = PathClassifier.new
      end

      it 'should be able to classify a path' do
        can_classify = PathClassifier.can_classify_path("")
        expect(can_classify).to be true
      end
    end
  end
end
