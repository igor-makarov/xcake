require 'spec_helper'
require 'yaml'
require 'simplecov'

SimpleCov.command_name 'test:integration'

RSpec::Matchers.define :eq_project do |expected|
  match do |actual|
    Xcodeproj::Differ.project_diff(actual, expected).nil?
  end
  failure_message do |actual|
    "expected that:\n#{actual.path} \nwould be equal to \n#{expected.path} \n\n" \
    "diff: \n#{Xcodeproj::Differ.project_diff(actual, expected).to_yaml}"
  end
end

RSpec::Matchers.define :succeed do
  match do |actual|
    system(actual)
  end
  failure_message do |actual|
    "expected that: `#{actual}` would succeed in dir: #{Dir.pwd}"
  end
end

module Xcake
  def self.make_helper
    FileUtils.rm_rf('temp')
    FileUtils.cp_r('input', 'temp')
    Dir.chdir('temp') do
      file_path = "#{Dir.pwd}/Cakefile"

      raise Xcake::Informative, "Couldn't find Cakefile" unless File.exist?(file_path)

      EventHooks.run_hook :before_cakefile_read
      file_contents = File.read(file_path)

      project = Project.new
      project.instance_eval(file_contents, file_path)

      context = XcodeprojContext.new

      dependency_provider = DependencyProvider.new(Generator)
      dependency_provider.tsort.each do |g|
        generator = g.new(context)
        project.accept(generator)
      end
    end
  end

  def self.list_files(directory)
    Dir.chdir(directory) { (Dir['**/*']) }
  end

  describe Xcake do
    Dir['spec/fixtures/integration/*'].each do |fixture|
      context fixture do
        it 'Should make fixture without failing' do
          Dir.chdir(fixture) do
            Xcake.make_helper
            expect(Dir['temp/*.xcodeproj']).to eq(%w(temp/Project.xcodeproj))
            expected_proj = Xcodeproj::Project.open('output/Project.xcodeproj')
            expect(Xcodeproj::Project.open('temp/Project.xcodeproj')).to eq_project(expected_proj)
          end
        end
        it 'Should build fixture with xcodebuild with no errors' do
          Dir.chdir(fixture) do
            Xcake.make_helper
            Dir.chdir('temp') do
              expect('xcodebuild clean build -sdk iphonesimulator &> xcode_output.txt').to succeed
            end
            expect(Xcake.list_files('temp')).to include(*Xcake.list_files('output'))
          end
        end
      end
    end
  end
end
