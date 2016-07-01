module Xcake
  # This class handles resolving the structure
  # of a project. Making sure that the structure of the
  # project is one Xcode can open and makes sense.
  #
  # As part of this it will create default configurations
  # if none are provided and will make sure both the project
  # and targets have all of the same configurations.
  class ProjectStructureGenerator < Generator

    attr_accessor :project

    def visit_project(project)

      puts "Resolving Project..."

      @project = project
    end

    def leave_project(project)
    end

    def visit_target(target)

      puts "Resolving target #{target.name}..."

      @project.all_configurations.each do |c|
        target.configuration(c.name, c.type)
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
