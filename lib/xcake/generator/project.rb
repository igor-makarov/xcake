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
        project = Xcode::Project.new(output_filepath, true)
        project.setup_for_xcake

        #TODO: Create subclass that manages all of this
                #   build_configuration = new(XCBuildConfiguration)
                # build_configuration.name = name
                # common_settings = Constants::PROJECT_DEFAULT_BUILD_SETTINGS
                # settings = ProjectHelper.deep_dup(common_settings[:all])
                # settings.merge!(ProjectHelper.deep_dup(common_settings[type]))
                # build_configuration.build_settings = settings
                # build_configuration_list.build_configurations << build_configuration
                # build_configuration

                  # config_list.default_configuration_name = 'Release'
                  # config_list.default_configuration_is_visible = '0'
                  # add_build_configuration('Debug', :debug)
                  # add_build_configuration('Release', :release)

        project.save
      end
    end
  end
end
