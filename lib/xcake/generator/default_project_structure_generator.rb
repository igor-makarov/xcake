module Xcake
  # This class handles generating the default structure
  # of a project. Making sure that the structure of the
  # project is one Xcode can open and makes sense.
  #
  # It will create default configurations or schemes
  # if none are provided and will make sure both the project
  # and targets have all of the same configurations.
  #
  class DefaultProjectStructureGenerator < Generator
    def self.dependencies
      [ProjectMetadataGenerator, TargetGenerator]
    end

    def visit_project(project)
      EventHooks.run_hook :before_resolving_project_structure, project
      @project = project

      # Make sure we always have a Release and Debug configuration as Xcode expects these
      # and these fixes bugs that can happen.
      @project.debug_configuration
      @project.release_configuration
    end

    def leave_project(project)
    end

    def visit_target(target)
      EventHooks.run_hook :before_resolving_target_structure, target

      @project.all_configurations.each do |c|
        target.configuration(c.name, c.type)
      end

      native_target = @context.native_object_for(target)

      return if native_target.test_target_type?
      return unless target.schemes.empty?

      target.all_configurations.each do |c|
        target.scheme "#{target.name}-#{c.name}" do |s|
          s.test_configuration = c.name
          s.launch_configuration = c.name
          s.profile_configuration = c.name
          s.analyze_configuration = c.name
          s.archive_configuration = c.name
        end
      end
    end

    def leave_target(target)
    end

    def visit_configuration(configuration)
    end

    def leave_configuration(configuration)
    end
  end
end
