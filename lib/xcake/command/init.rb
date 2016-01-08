require "claide"

module Xcake
  class InitCommnd < CLAide::Command

    self.command = "xcake"
    self.version = VERSION
    self.description = "Create and maintain Xcode project files easily."

    def run
      file_path = "#{Dir.pwd}/Cakefile"

      unless File.exist?(file_path)
        raise Xcake::Informative, "Couldn't find Cakefile"
      end

      puts "Reading Cakefile..."
      file_contents = File.read(file_path)
      cakefile = eval(file_contents)

      resolver = ProjectStructureResolver.new
      cakefile.accept(resolver)

      generator = Generator::Project.new
      cakefile.accept(generator)
    end
  end
end
