require 'claide'

module Xcake
  class Command < CLAide::Command

    self.command = 'xcake'
    self.description = 'Create and maintain Xcode project files easily.'

    def run

#TODO: Unit test all of this.
      cakefile = Cakefile.new do |c|

        c.debug_build_configuration :Debug
        c.debug_build_configuration :Beta
        c.release_build_configuration :Release

        c.application_for :ios, 8.0 do |t|

          #c.language = :swift
          t.name = "Sup"
          t.include_files = "./**/*.*"
          t.exclude_files = "./**/*.rb"

          t.all_build_configurations.settings["INFOPLIST_FILE"] = "Info.plist"

        end

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
