require 'pathname'
require 'xcodeproj'

module Xcake
  class XcodeprojContext
    include Context

    attr_accessor :project

    def create_object_for(dsl_object)
      case dsl_object
      when Project
        create_object_for_project(dsl_object)
      when Target
        create_object_for_target(dsl_object)
      when Configuration
        create_object_for_configuration(dsl_object)
      when Node
        create_object_for_node(dsl_object)
      else
        nil
      end
    end

    def create_object_for_project(project)
      @project = Xcode::Project.new("./#{project.name}.xcodeproj", true)
      @project.setup_for_xcake
      @project
    end

    def create_object_for_target(target)
      @project.new_target(target)
    end

    def create_object_for_configuration(configuration)
      @project.new_configuration(configuration)
    end

    def create_object_for_node(node)
      @project.new_group(node)
    end

    def file_reference_for_path(path)
      pathname = Pathname.new path
      @project.file_reference_for_path(pathname)
    end
  end
end
