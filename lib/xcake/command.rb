require 'claide'

module Xcake
  class Command < CLAide::Command

    self.command = 'xcake'
    self.description = 'Create and maintain Xcode project files easily.'

    def run

      puts "Reading Cakefile..."
      file_contents = File.read("#{Dir.pwd}/Cakefile")
      cakefile = eval(file_contents)

      defaults_generator = Generator::Defaults.new
      cakefile.accept(defaults_generator)

      project_generator = Generator::Project.new
      cakefile.accept(project_generator)
      #project_generator.build - Needed ?
    end
  end
end
