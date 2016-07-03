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

        unless configuration.configuration_file.nil?
          xcconfig = install_xcconfig(configuration)
          native_configuration_object.base_configuration_reference = xcconfig
        end
      end
    end

    def install_xcconfig(configuration)
      # TODO: Remove need to construct a Node Object to do this.
      node = Node.new
      node.path = configuration.configuration_file
      native_group = @context.native_object_for(node)
      native_group.new_reference(node.path)
    end
  end
end
