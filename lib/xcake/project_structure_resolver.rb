module Xcake
  # This class handles resolving the structure
  # of a project. Making sure that the structure of the
  # project is one Xcode can open and makes sense.
  #
  # As part of this it will create default configurations
  # if none are provided and will make sure both the project
  # and targets have all of the same configurations.
  class ProjectStructureResolver

    include Visitor

    # @return [Project] the project to resolve structure for
    attr_accessor :project

    protected

    def visit_project(project)

      puts "Resolving Project..."

      @project = project

      @project.debug_configuration :Debug if @project.debug_configurations.count == 0
      @project.release_configuration :Release if @project.release_configurations.count == 0
    end

    def leave_project(project)
    end

    def visit_target(target)

      puts "Resolving target #{target.name}..."

      @project.debug_configurations.each do |b|
        target.debug_configuration(b.name)
      end

      @project.release_configurations.each do |b|
        target.release_configuration(b.name)
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
