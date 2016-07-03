require 'hooks'

module Xcake
  class EventHooks
    include Hooks

    # Defines hook which is ran after a Cakefile is initilized.
    #
    define_hooks :after_cakefile_init

    # Defines hook which is ran before we start reading the cakefile
    #
    define_hooks :before_cakefile_read
  end
end
