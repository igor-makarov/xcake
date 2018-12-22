require 'pathname'
require 'xcodeproj'

module Xcake
  class XcodeprojContext
    include Context

    attr_accessor :project

    def create_object_for(dsl_object) # rubocop:disable Metrics/CyclomaticComplexity
      case dsl_object
      when BuildPhase
        create_object_for_build_phase(dsl_object)
      when BuildRule
        create_object_for_build_rule(dsl_object)
      when Project
        create_object_for_project(dsl_object)
      when Target
        create_object_for_target(dsl_object)
      when Configuration
        create_object_for_configuration(dsl_object)
      when Scheme
        create_object_for_scheme(dsl_object)
      end
    end

    def create_object_for_build_phase(build_phase)
      @project.new(build_phase.build_phase_type)
    end

    def create_object_for_build_rule(_build_rule)
      @project.new(Xcodeproj::Project::Object::PBXBuildRule)
    end

    def create_object_for_project(project)
      project_path = "./#{project.name}.xcodeproj"

      FileUtils.remove_dir(project_path) if File.exist?(project_path)

      @project = Xcode::Project.new(project_path, true)
      @project.setup_for_xcake
      @project
    end

    def create_object_for_target(target)
      @project.new_target(target)
    end

    def create_object_for_configuration(configuration)
      @project.new_configuration(configuration)
    end

    def create_object_for_scheme(_scheme)
      Xcode::Scheme.new
    end

    def file_reference_for_path(path)
      pathname = Pathname.new path
      @project.file_reference_for_path(pathname)
    end

    def scheme_list
      @scheme_list ||= Xcode::SchemeList.new(@project)
    end
  end
end
