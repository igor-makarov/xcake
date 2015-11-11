require 'claide'

module Xcake
  class Command < CLAide::Command

    self.command = 'xcake'
    self.description = 'Create and maintain Xcode project files easily.'

    def run
      file_contents = File.read("#{Dir.pwd}/Cakefile")
      cakefile = eval(file_contents)

      #Old Generator System
      # generator = Generator::Project.new(cakefile)
      # generator.build

      generator = Generator::Project.new
      cakefile.accept(generator)
      #generator.build - Needed ?
    end
  end
end
