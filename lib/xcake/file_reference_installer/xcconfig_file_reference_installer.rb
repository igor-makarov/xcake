module Xcake
  # This build phase generator detects xcconfigs
  # files, adds them to the project and tries to connect them
  # to a configuration.
  #
  # TODO: In future we will implement a 2 phase file installer system.
  class XCConfigFileReferenceInstaller < FileReferenceInstaller

    def self.dependencies
      []
    end

    def self.can_install_node(node)
      File.file?(node.path) &&
        [".xcconfig"].include?(File.extname(node.path))
    end

    def visit_node(node)
      super

      puts "-------------"
      puts " * node: #{node}"
    end

    def add_build_configurations_for(configuration_object)
      puts "??? Creating build configurations for #{configuration_object}..."

      configuration_object.all_configurations.each do |configuration|
        # puts "Creating build configuration #{configuration.name} for #{configuration_object}..."
        #
        # build_configuration = @context.native_object_for(configuration)
        # build_configuration.name = configuration.name
        # build_configuration.build_settings = configuration.settings
        #
        # native_configuration_object = @context.native_object_for(configuration_object)
        # native_configuration_object.build_configurations << build_configuration

        if configuration.configuration_file != nil
          puts "Adding xcconfig #{configuration.configuration_file}..."

          configuration_file = configuration.configuration_file
          xcconfig = @context.project.new_file_reference(configuration_file)
          build_configuration.base_configuration_reference = xcconfig
        end
      end
    end


    def add_file_reference_to_target(file_reference, target)
          target.frameworks_build_phases.add_file_reference(file_reference)
    end
  end
end
