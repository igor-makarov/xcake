module Xcake
  class ProjectGenerator < Generator

    def self.dependencies
      Generator.repository.select do |g|
        g != self
      end
    end

    def visit_project(project)

      puts "Creating Project..."

      native_project = @context.native_object_for(project)
      native_project.class_prefix = project.class_prefix if project.class_prefix
      native_project.organization = project.organization if project.organization
    end

    def leave_project(project)
      native_project = @context.native_object_for(project)
      native_project.save
      project.run_hook :after_save
      puts "Done!"
    end
  end
end
