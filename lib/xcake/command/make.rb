require 'molinillo'

#TODO: Reduce lines of code here :)
module Xcake
  class Command
    class Make < Command
      self.summary = "Makes the Xcode project from a Cakefile"
      self.description = "Makes the Xcode project from a Cakefile"

      def run
        file_path = "#{Dir.pwd}/Cakefile"

        unless File.exist?(file_path)
          raise Xcake::Informative, "Couldn't find Cakefile"
        end

        puts "Reading Cakefile..."
        file_contents = File.read(file_path)

        project = Project.new
        project.instance_eval(file_contents)

        context = XcodeprojContext.new(project)

        #TODO: Debug logs for generator
        repository = Generator.repository
        #puts "Registered Generators #{repository}"

        #TODO: Don't use class as name
        dependency_provider = DependencyProvider.new(repository)
        resolver = Molinillo::Resolver.new(dependency_provider, UI.new)
        resolution = resolver.resolve(Generator.repository)
        resolution.tsort.map do |g|
          #puts "Running #{g.name}..."
          generator = g.name.new(context)
          project.accept(generator)
        end
      end
    end
  end
end
