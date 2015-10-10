require 'claide'

module Xcake
  class Command < CLAide::Command

    self.command = 'xcake'
    self.description = 'Create and maintain Xcode project files easily.'

    def run
      cakefile = Cakefile.new
      genrator = Generator::Project.new(cakefile)
    end
  end
end
