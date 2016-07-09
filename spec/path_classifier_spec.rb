require 'spec_helper'

module Xcake
  describe PathClassifier do
    context 'when created' do
      before :each do
        @context = double('Context')
        @installer = PathClassifier.new
      end

      it 'should not be able to classify a path' do
        can_classify = PathClassifier.can_classify_path("")
        expect(can_classify).to be false
      end

      it 'should not include any path' do
        should_include = PathClassifier.should_include_path("")
        expect(should_include).to be false
      end
    end
  end
end
