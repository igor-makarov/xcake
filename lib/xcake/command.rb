require 'claide'

module Xcake
  class Command < CLAide::Command

    self.command = 'xcake'
    self.description = 'Create and maintain Xcode project files easily.'

    def run
      cakefile = Cakefile.new do |c|
        c.build_configuration "Debug"
        c.build_configuration "Beta"
        c.build_configuration "Release"

#TODO: Improve this syntax for specifying target type.
        c.target "Sup", :application, :ios do |t|

          t.include_files = "./**/*.*"
          t.exclude_files = "./**/*.rb"

        end

        c.target "SupTests"
      end

      generator = Generator::Project.new(cakefile)
      generator.build
    end
  end
end
