module Xcake
  class Command
    class Init < Command

      self.summary = "Initilises an example Cakefile for creating a project"
      self.description = "Initilises an example Cakefile for creating a project"

      def run
        #TODO: Move this to file Xcake reads in
        cakefile_contents = "Project.new do |p| end"
        File.write("Cakefile", cakefile_contents)

        puts "Open Cakefile to edit and run xcake bake to get your xcode project"
      end
    end
  end
end
