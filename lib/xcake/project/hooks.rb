require 'hooks'

module Xcake
  class Project
    include Hooks

    # Defines hook which is ran after project is saved.
    #
    define_hooks :after_save
  end
end
