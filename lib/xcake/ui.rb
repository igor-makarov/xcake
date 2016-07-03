require 'cork'

# TODO: i18n this.
# TODO: Different modes depending on --verbose, and CI
module Xcake
  class UI
    def self.register_ui_hooks

      board = Cork::Board.new()

      Xcake::EventHooks.after_cakefile_init do
        board.notice('Open Cakefile to edit and run xcake make to get your xcode project')
      end

      Xcake::EventHooks.before_cakefile_read do
        board.puts('Reading Cakefile...')
      end
    end
  end
end
