module Xcake
  class Target

    include BuildConfigurable

    attr_accessor :name
    attr_accessor :type
    attr_accessor :platform
    attr_accessor :deployment_target
    attr_accessor :include_files
    attr_accessor :exclude_files
    attr_accessor :system_frameworks

    def initialize(&block)
      block.call(self) if block_given?

      #TODO: Setup defaults
      # TODO: Figure out how to pull this off
      #
      # target.build_configuration_list = configuration_list(project, platform, deployment_target, type, language)
      #
      # # Product
      # product = product_group.new_product_ref_for_target(name, type)
      # target.product_reference = product
      #
    end

    def system_frameworks
      @system_frameworks ||= default_system_frameworks_for self.platform
    end

    def default_system_frameworks_for(platform)
      (platform == :ios) ? ['Foundation'] : ['Cocoa']
    end
  end
end
