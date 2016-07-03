require 'cork'

# TODO: i18n this.
board = Cork::Board.new()

Xcake::EventHooks.after_cakefile_init do
  board.notice('Open Cakefile to edit and run xcake make to get your xcode project')
end

Xcake::EventHooks.after_cakefile_init do
  board.notice('Open Cakefile to edit and run xcake make to get your xcode project')
end
