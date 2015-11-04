require 'claide'

module Xcake
  class Command < CLAide::Command

    self.command = 'xcake'
    self.description = 'Create and maintain Xcode project files easily.'

    def run

      cakefile = Cakefile.new do |c|

        #c.default_configuration :release

        #c.build_configuration :all do |b|
          #b["BRIDGE_HEADER"] = "./Magic.pch"
          #b.preprocessor_macro["API_URL"] = "http://supdev.firebaseio.com/".to_objc
        #end

        #c.build_configuration :debug do |b|
          #b.preprocessor_macro["DEBUG"] = 1
          #b.preprocessor_macro["LOG"] = 1
        #end

        #c.build_configuration :beta do |b|
          #b.preprocessor_macro["BETA"] = 1
          #b.preprocessor_macro["LOG"] = 1
        #end

        #c.build_configuration :release do |b|
          #b.preprocessor_macro["RELEASE"] = 1
          #b.preprocessor_macro["LOG"] = 0
        #end

        c.build_configuration "Debug"
        c.build_configuration "Beta"
        c.build_configuration "Release"

        c.application_for :ios, 8.0 do |t|

          t.name = "Sup"
          t.include_files = "./**/*.*"
          t.exclude_files = "./**/*.rb"
          #c.language = :swift

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
