require 'xcodeproj'

module Xcake
  module Generator
    class BuildConfiguration

      attr_accessor :cakefile
      attr_accessor :project

      def initialize(cakefile)
        self.cakefile = cakefile
      end
    end
  end
end
