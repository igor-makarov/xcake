module Xcake
  class TargetLibraryGenerator < Generator
    def self.dependencies
      [TargetGenerator, ConfigurationGenerator]
    end

    def visit_target(target)
      puts "Integrating System Libraries for #{target}..."

      native_target = @context.native_object_for(target)
      if target.system_libraries
        native_target.add_system_libraries(target.system_libraries)
      end
    end
  end
end
