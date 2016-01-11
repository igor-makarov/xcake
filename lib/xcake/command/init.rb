module Xcake
  class Command
    class InitCommand < Command
      self.description = "Initilises an example Cakefile for creating a project"

      def run
        puts "Make me a cakefile dammit"
      end
    end
  end
end
