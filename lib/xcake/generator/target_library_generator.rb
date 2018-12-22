module Xcake
  class TargetLibraryGenerator < Generator
    def self.dependencies
      [TargetGenerator, ConfigurationGenerator]
    end

    def visit_target(target)
      system_libraries = target.system_libraries.to_a

      return if system_libraries.empty?

      EventHooks.run_hook :before_adding_system_library, target

      native_target = @context.native_object_for(target)
      native_target.add_system_libraries(system_libraries)
    end
  end
end
