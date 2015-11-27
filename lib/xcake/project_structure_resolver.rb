module Xcake
  class ProjectStructureResolver

    include Visitor

    attr_accessor :project

    def visit_project(project)

      puts "Resolving Project..."

      @project = project

      @project.debug_configuration :debug if @project.debug_configurations.count == 0
      @project.release_configuration :release if @project.release_configurations.count == 0
    end

    def leave_project(project)
    end

    def visit_target(target)

      puts "Resolving target #{target.name}..."

      @project.debug_configurations.each do |b|
        target.debug_configurations(b.name)
      end

      @project.release_configurations.each do |b|
        target.release_configurations(b.name)
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
