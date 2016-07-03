require 'cork'

module Xcake
  class UI
    def initialize
      # TODO: i18n this.
      board = Cork::Board.new()

      Xcake::EventHooks.after_cakefile_init do
        board.notice('Open Cakefile to edit and run xcake make to get your xcode project')
      end

      Xcake::EventHooks.after_exception do
        board.warn('An Error Occured')
      end
    end
  end
end
