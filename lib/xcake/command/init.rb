module Xcake
  class Command
    class Init < Command
      self.description = "Initilises an example Cakefile for creating a project"

      def run
        puts "Make me a cakefile dammit"
      end
    end
  end
end
