require 'claide'

module Xcake
  class Command < CLAide::Command

    include CLAide::InformativeError

    self.command = 'xcake'
    self.version = VERSION
    self.description = 'Create and maintain Xcoe project files easily.'

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
