require 'claide'

module Xcake
  class Command < CLAide::Command

    self.command = 'xcake'
    self.version = VERSION
    self.description = 'Create and maintain Xcode project files easily.'

    def run

      puts "Reading Cakefile..."
      file_contents = File.read("#{Dir.pwd}/Cakefile")
      cakefile = eval(file_contents)

      resolver = ProjectStructureResolver.new
      cakefile.accept(resolver)

      generator = Generator::Project.new
      cakefile.accept(generator)
    end
  end
end
