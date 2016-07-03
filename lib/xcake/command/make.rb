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
        project.instance_eval(file_contents, file_path)

        context = XcodeprojContext.new

        dependency_provider = DependencyProvider.new(Generator)
        dependency_provider.tsort.each do |g|
          generator = g.new(context)
          project.accept(generator)
        end
      end
    end
  end
end
