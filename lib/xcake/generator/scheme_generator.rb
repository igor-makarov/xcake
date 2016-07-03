module Xcake
  class SchemeGenerator < Generator
    def self.dependencies
      [TargetGenerator, ConfigurationGenerator]
    end

    def visit_project(project)
      UI.puts 'Creating User Schemes...'

      native_project = @context.native_object_for(project)
      native_project.recreate_user_schemes
    end
  end
end
