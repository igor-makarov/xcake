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

    # Defines hook which is ran before we start creating the Xcode Project
    #
    define_hooks :before_creating_xcode_project

    # Defines hook which is ran before we start creating a Target
    #
    define_hooks :before_creating_target
  end
end
