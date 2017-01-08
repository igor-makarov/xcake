require 'xcodeproj'

module Xcake
  # This generator processes the configurations
  # and creates xcode build configurations.
  #
  class ConfigurationGenerator < Generator
    def self.dependencies
      [TargetGenerator, DefaultProjectStructureGenerator]
    end

    def visit_project(project)
      create_build_configurations_for(project)
    end

    def visit_target(target)
      create_build_configurations_for(target)
    end

    def create_build_configurations_for(configuration_object)
      EventHooks.run_hook :before_creating_build_configurations, configuration_object

      configuration_object.all_configurations.each do |configuration|
        EventHooks.run_hook :before_creating_build_configuration, configuration, configuration_object

        build_configuration = @context.native_object_for(configuration)
        build_configuration.name = configuration.name
        build_configuration.build_settings = configuration.settings

        unless configuration.configuration_file.nil?
          EventHooks.run_hook :before_attaching_xcconfig, configuration
          configuration_file = configuration.configuration_file
          file_reference = @context.file_reference_for_path(configuration_file)
        end

        build_configuration.base_configuration_reference = file_reference

        native_configuration_object = @context.native_object_for(configuration_object)
        native_configuration_object.build_configurations << build_configuration
      end
    end
  end
end
