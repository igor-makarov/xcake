require 'xcodeproj'

module Xcake
  module Generator
    class Project

      attr_accessor :cakefile

      def initialize(cakefile)

        self.cakefile = cakefile
      end

      def build
        puts "Build :)"
      end
    end
  end
end
