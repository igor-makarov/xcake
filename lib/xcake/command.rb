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

        c.target "Sup", :application, :ios do |t|

          t.include_files = "./**/*.*"
          t.exclude_files = "./**/*.rb"

        end

        c.target "SupTests"

#TODO: Build this new syntax, but add methods into Target to make it possible with this.
        #c.application do |a|
          #c.name = "Sup"
          #c.platform = iOS(8.1)
          #c.language = :swift
        #end

        #c.unit_tests_for "Sup" |t|
          #t.name = "SupTest"
          #t.language = :swift
        #end

        #c.ui_tests_for "Sup" |t|
          #t.name = "SupTest"
          #t.language = :swift
        #end

        #c.extension_for "Sup" do |e|
          #e.name = "SupWatchExtension"
          #e.platform = Watch(2.0)
          #e.language = :swift
        #end

        #c.library do |e|
          #e.name = "SupCore"
          #e.platform = Watch(2.0)
          #e.language = :swift
        #end

        #c.framework do |e|
          #e.name = "SupCore"
          #e.platform = Watch(2.0)
          #e.language = :swift
        #end

      end

      generator = Generator::Project.new(cakefile)
      generator.build
    end
  end
end
