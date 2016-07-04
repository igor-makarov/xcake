module Xcake
  class SchemeGenerator < Generator
    def self.dependencies
      [TargetGenerator, ConfigurationGenerator]
    end

    def visit_project(project)
      EventHooks.run_hook :before_adding_user_schemes

      native_project = @context.native_object_for(project)
      native_project.recreate_user_schemes
    end
  end
end
