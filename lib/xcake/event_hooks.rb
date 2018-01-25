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

    # Defines hook which is ran before we start resolving
    # issues with the Project structure
    #
    define_hooks :before_resolving_project_structure

    # Defines hook which is ran before we start resolving
    # issues with the Target structure
    #
    define_hooks :before_resolving_target_structure

    # Defines hook which is ran before we start creating build configurations
    # for a particular Xcode Project Object
    #
    define_hooks :before_creating_build_configurations

    # Defines hook which is ran before we start creating a
    # build configurations for a particular Xcode Project Object
    #
    define_hooks :before_creating_build_configuration

    # Defines hook which is ran before we attach a XCConfig to a
    # build configuration for a particular Xcode Project Object
    #
    define_hooks :before_attaching_xcconfig

    # Defines hook which is ran before we add a system library
    # to a target
    #
    define_hooks :before_adding_system_library

    # Defines hook which is ran before we add a system framework
    # to a target
    #
    define_hooks :before_adding_system_framework

    # Defines hook which is ran before we add build rules
    # to a target
    #
    define_hooks :before_adding_build_rules

    # Defines hook which is ran before we add build phases
    # to a target
    #
    define_hooks :before_adding_build_phases

    # Defines hook which is ran before we create the user schemes
    #
    define_hooks :before_adding_user_schemes

    # Defines hook which is ran before we add a file to the project
    #
    define_hooks :before_adding_file

    # Defines hook which is ran before we add a custom build rule to
    # a target
    #
    define_hooks :before_adding_custom_build_rule

    # Defines hook which is ran before we add a custom build phase to
    # a target
    #
    define_hooks :before_adding_custom_build_phase

    # Defines hook which is ran before we add a embed watch app build phase to
    # a target
    #
    define_hooks :before_adding_embed_watch_app_phase

    # Defines hook which is ran before we add a embed watch extension build
    # phase to a target
    #
    define_hooks :before_adding_embed_watch_extension_phase

    # Defines hook which is ran after we save the generated project file
    #
    define_hooks :after_project_save
  end
end
