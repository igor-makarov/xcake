module Xcake
  class Command
    class Init < Command

      self.summary = "Initilises an example Cakefile for creating a project"
      self.description = "Initilises an example Cakefile for creating a project"

      def run

        cakefile_path = "#{File.dirname(__FILE__)}/../resources/Cakefile"
        cakefile_contents = File.read(cakefile_path)
        File.write("Cakefile", cakefile_contents)

        puts "Open Cakefile to edit and run xcake bake to get your xcode project"
      end
    end
  end
end
