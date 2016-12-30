module Xcake
  class SchemeGenerator < Generator
    def self.dependencies
      [TargetGenerator, ConfigurationGenerator]
    end

    def visit_project(project)
      EventHooks.run_hook :before_adding_user_schemes

      native_project = @context.native_object_for(project)
      @scheme_list = SchemeList.new(native_project)
    end

    def visit_target(target)
      @scheme_list.recreate_schemes
    end

    def leave_project(project)
      @scheme_list.save(path)
    end
  end
end
