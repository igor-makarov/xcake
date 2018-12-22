module Xcake
  class ProjectGenerator < Generator
    def self.dependencies
      Generator.descendants.reject do |g|
        g == self
      end
    end

    def leave_project(project)
      native_project = @context.native_object_for(project)
      native_project.save
      project.run_hook :after_save

      EventHooks.run_hook :after_project_save
    end
  end
end
