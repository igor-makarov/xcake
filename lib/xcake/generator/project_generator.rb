module Xcake
  class ProjectGenerator < Generator

    def self.dependencies
      Generator.descendants.select do |g|
        g != self
      end
    end

    def leave_project(project)
      native_project = @context.native_object_for(project)
      native_project.save
      project.run_hook :after_save
      puts "Done!"
    end
  end
end
