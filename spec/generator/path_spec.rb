require 'spec_helper'

module Xcake
  module Generator
    describe Path do

      it "should store the project" do

        project = double()
        generator = Path.new(project)

        expect(generator.project).to be(project)
      end

      #No Path

      #Path - No generator

      #Path - Generator
    end
  end
end
