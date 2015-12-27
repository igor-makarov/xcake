require 'claide'

module Xcake
  class Command < CLAide::Command

    include CLAide::InformativeError

    self.command = 'xcake'
    self.version = VERSION
    self.description = 'Create and maintain Xcoe project files easily.'

    def run
      file_path = "#{Dir.pwd}/Cakefile"
      raise Informative, "Couldn't find Cakefile" unless File.exist?(file_path)

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
