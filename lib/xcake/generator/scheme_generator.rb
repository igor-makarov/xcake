module Xcake
  class SchemeGenerator < Generator
    def self.dependencies
      [TargetGenerator, ConfigurationGenerator]
    end

    def visit_project(project)
      EventHooks.run_hook :before_adding_user_schemes

      @scheme_list = @context.scheme_list
    end

    def visit_target(target)
      native_target = @context.native_object_for(target)
      @scheme_list.create_schemes_for_target(native_target) unless native_target.test_target_type?
    end

    def leave_project(project)
      native_project = @context.native_object_for(project)
      @scheme_list.save(native_project.path)
    end
  end
end
