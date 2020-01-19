require 'hooks'

module Xcake
  class Project
    include Hooks
    include Hooks::InstanceHooks

    # Defines hook which is ran before project is saved.
    #
    define_hooks :before_save

    # Defines hook which is ran after project is saved.
    #
    define_hooks :after_save
  end
end
