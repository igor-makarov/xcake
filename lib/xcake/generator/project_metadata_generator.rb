module Xcake
  class ProjectMetadataGenerator < Generator
    def visit_project(project)
      EventHooks.run_hook :before_creating_xcode_project

      native_project = @context.native_object_for(project)
      native_project.class_prefix = project.class_prefix if project.class_prefix
      native_project.organization = project.organization if project.organization
    end
  end
end
