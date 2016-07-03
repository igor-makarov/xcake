require 'hooks'

module Xcake
  class EventHooks
    include Hooks

    # Defines hook which is ran after a Cakefile is initilized.
    #
    define_hooks :after_cakefile_init

    # Defines hook which is ran after an exception
    #
    define_hooks :after_exception
  end
end
