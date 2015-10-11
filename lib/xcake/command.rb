require 'claide'

module Xcake
  class Command < CLAide::Command

    self.command = 'xcake'
    self.description = 'Create and maintain Xcode project files easily.'

    def run
      cakefile = Cakefile.new do |c|

        c.build_configuration "Debug"
      end

      generator = Generator::Project.new(cakefile)
      generator.build
    end
  end
end
