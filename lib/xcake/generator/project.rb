require 'xcodeproj'

module Xcake
  module Generator
    class Project

      attr_accessor :cakefile

      def initialize(cakefile)
        self.cakefile = cakefile
      end

      def output_filepath
        "./#{self.cakefile.project_name}.xcodeproj"
      end

      def build
        project = Xcodeproj::Project.new(output_filepath, true)
        project.setup_for_xcake
        
        # root_object.remove_referrer(self) if root_object
        # @root_object = new(PBXProject)
        # root_object.add_referrer(self)
        #
        # root_object.main_group = new(PBXGroup)
        # root_object.product_ref_group = root_object.main_group.new_group('Products')
        #
        # config_list = new(XCConfigurationList)
        # root_object.build_configuration_list = config_list
        # config_list.default_configuration_name = 'Release'
        # config_list.default_configuration_is_visible = '0'
        # add_build_configuration('Debug', :debug)
        # add_build_configuration('Release', :release)
        #
        # new_group('Frameworks')

        project.save
      end
    end
  end
end
