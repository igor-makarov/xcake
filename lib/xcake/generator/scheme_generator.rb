module Xcake
  class SchemeGenerator < Generator
    def self.dependencies
      [TargetGenerator, ConfigurationGenerator]
    end

    def visit_project(_project)
      EventHooks.run_hook :before_adding_user_schemes
    end

    def visit_target(target)
      scheme_list = @context.scheme_list
      native_target = @context.native_object_for(target)

      scheme_list.create_schemes_for_target(native_target) unless native_target.test_target_type?
    end

    def leave_project(project)
      scheme_list = @context.scheme_list
      native_project = @context.native_object_for(project)

      scheme_list.save(native_project.path)
    end
  end
end
