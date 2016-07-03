require 'hooks'

module Xcake
  class EventHooks
    include Hooks

    # Defines hook which is ran after a Cakefile is initilized.
    #
    define_hooks :after_cakefile_init
  end
end
