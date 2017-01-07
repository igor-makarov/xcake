module Xcake
  class SchemeGenerator < Generator
    def self.dependencies
      [TargetGenerator, DefaultProjectStructureGenerator, ConfigurationGenerator]
    end

    def visit_project(project)
      EventHooks.run_hook :before_adding_user_schemes
      @project = @context.native_object_for(project)
    end

    def visit_target(target)
      scheme_list = @context.scheme_list
      native_target = @context.native_object_for(target)

      target.schemes.each do |scheme| 

        native_scheme = @context.native_object_for(scheme)
        native_scheme.name = scheme.name

          scheme_list.supress_autocreation_of_target(target)

          #TODO: Find multiple testing targets, move this into the DSL ?
          unit_test_target = @project.find_unit_test_target_for_target(target)

          scheme.configure_with_targets(target, unit_test_target)

          scheme.test_action.build_configuration = scheme.test_configuration
          scheme.launch_action.build_configuration = scheme.launch_conifuration
          scheme.profile_action.build_configuration = scheme.profile_configuration
          scheme.analyze_action.build_configuration = scheme.analyze_configuration
          scheme.archive_action.build_configuration = scheme.archive_configuration

          if unit_test_target
            #TODO: Remove need for this in the DSL
            unit_test_target.add_dependency(target)
            scheme_list.supress_autocreation_of_target(unit_test_target)
          end

          scheme_list.schemes << scheme
      end
    end

    def leave_project(project)
      scheme_list = @context.scheme_list
      scheme_list.save
    end
  end
end
