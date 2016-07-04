require 'cork'

# TODO: i18n this.
# TODO: Different modes depending on --verbose, and CI
module Xcake
  class UI
    def self.register_ui_hooks

      board = Cork::Board.new()

      EventHooks.after_cakefile_init do
        board.notice 'Open Cakefile to edit and run xcake make to get your xcode project'
      end

      EventHooks.before_cakefile_read do
        board.puts_indented '- Reading Cakefile'
      end

      EventHooks.before_creating_xcode_project do
        board.puts_indented '- Creating Project'
      end

      EventHooks.before_creating_target do |target|
        board.puts_indented "- Creating #{target}"
      end

      EventHooks.before_resolving_project_structure do
        board.puts_indented "- Resolving Project"
      end

      EventHooks.before_resolving_target_structure do |target|
        board.puts_indented "- Resolving #{target}"
      end

      EventHooks.before_creating_build_configurations do |configurable|
        board.puts_indented "- Creating build configurations for #{configurable}"
      end

      EventHooks.before_creating_build_configuration do |configuration, configurable|
        board.puts_indented "- Creating build configuration #{configuration.name} for #{configurable}"
      end

      EventHooks.before_attaching_xcconfig do |configuration|
        board.puts_indented "- Attaching XCConfig #{configuration.configuration_file} to build configuration #{configuration.name}"
      end

      EventHooks.before_adding_system_library do |target|
        board.puts_indented "- Integrating System Libraries #{target.system_libraries} for #{target}"
      end

      EventHooks.before_adding_system_library do |target|
        board.puts_indented "- Integrating System Libraries #{target.system_libraries} for #{target}"
      end

      EventHooks.before_adding_system_framework do |target|
        board.puts_indented "- Integrating System Frameworks #{target.system_frameworks} for #{target}"
      end

      EventHooks.before_adding_build_phases do |target|
        board.puts_indented "- Creating build phases for #{target}"
      end

      EventHooks.before_adding_user_schemes do
        board.puts_indented '- Creating User Schemes'
      end

      EventHooks.after_project_save do
        board.notice 'Done!'
      end
    end
  end
end
