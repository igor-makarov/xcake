module Xcake
  class Command
    class Init < Command

      self.summary = "Initilises an example Cakefile for creating a project"
      self.description = "Initilises an example Cakefile for creating a project"

      def run
        puts "Make me a cakefile dammit"
      end
    end
  end
end
