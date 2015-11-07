require 'claide'

module Xcake
  class Command < CLAide::Command

    self.command = 'xcake'
    self.description = 'Create and maintain Xcode project files easily.'

    def run
      file_contents = File.read("#{Dir.pwd}/Cakefile")
      cakefile = eval(file_contents)

      generator = Generator::Project.new(cakefile)
      generator.build
    end
  end
end
