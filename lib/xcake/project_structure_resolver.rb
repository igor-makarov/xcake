module Xcake
  class ProjectStructureResolver

    include Visitor

    attr_accessor :project

    def visit_project(project)

      puts "Resolving Project..."

      @project = project

      @project.debug_build_configuration :debug if @project.debug_build_configurations.count == 0
      @project.release_build_configuration :release if @project.release_build_configurations.count == 0
    end

    def leave_project(project)
    end

    def visit_target(target)

      puts "Resolving target #{target.name}..."

      @project.debug_build_configurations.each do |b|
        target.debug_build_configuration(b.name)
      end

      @project.release_build_configurations.each do |b|
        target.release_build_configuration(b.name)
      end
    end

    def leave_target(target)
    end

    def visit_buildconfiguration(configuration)
    end

    def leave_buildconfiguration(configuration)
    end
  end
end
