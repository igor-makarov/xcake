require 'cork'

# TODO: i18n this.
# TODO: Different modes depending on --verbose, and CI
module Xcake
  class UI
    def self.register_ui_hooks

      board = Cork::Board.new()

      EventHooks.after_cakefile_init do
        board.notice('Open Cakefile to edit and run xcake make to get your xcode project')
      end

      EventHooks.before_cakefile_read do
        board.puts('Reading Cakefile...')
      end

      EventHooks.before_creating_xcode_project do
        board.title('Creating Project')
      end

      EventHooks::before_creating_target do |target|
        board.title("Creating target #{target.name}...")
      end
    end
  end
end
