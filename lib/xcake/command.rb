require 'claide'

module Xcake
  class Command < CLAide::Command

    self.command = 'xcake'
    self.description = 'Create and maintain Xcode project files easily.'

    def run

      genrator = Generator::Project.new
    end
  end
end
