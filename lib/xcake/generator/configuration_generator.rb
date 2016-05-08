require 'xcodeproj'

module Xcake
  # This generator processes the configurations
  # and creates xcode build configurations.
  #
  class ConfigurationGenerator < Generator

    def self.dependencies
      [TargetGenerator, ProjectStructureGenerator]
    end

    def visit_project(project)
      create_build_configurations_for(project)
    end

    def visit_target(target)
      create_build_configurations_for(target)
    end

    def create_build_configurations_for(configuration_object)
      puts "Creating build configurations for #{configuration_object}..."

      configuration_object.all_configurations.each do |configuration|
        puts "Creating build configuration #{configuration.name} for #{configuration_object}..."

        build_configuration = @context.native_object_for(configuration)
        build_configuration.name = configuration.name
        build_configuration.build_settings = configuration.settings

        native_configuration_object = @context.native_object_for(configuration_object)
        native_configuration_object.build_configurations << build_configuration

        if configuration.configuration_file != nil
          puts "Adding xcconfig #{configuration.configuration_file}..."

          xcconfig = install_xcconfig(configuration)
          build_configuration.base_configuration_reference = xcconfig
        end
      end
    end

    def install_xcconfig(configuration)
      build_configuration = @context.native_object_for(configuration)
      native_project = build_configuration.project

      path     = configuration.configuration_file
      basename = File.basename(path)
      parent   = File.dirname(path)

      group = native_project.main_group.find_subpath(parent, true)
      group[basename] || group.new_reference(path)
    end
  end
end
