module Xcake
  class TargetFrameworkGenerator < Generator
    def self.dependencies
      [TargetGenerator, ConfigurationGenerator]
    end

    def visit_target(target)
      return if target.system_frameworks.nil?

      EventHooks.run_hook :before_adding_system_framework, target

      native_target = @context.native_object_for(target)

      system_frameworks = target.system_frameworks
      native_target.add_system_frameworks(system_frameworks)
    end
  end
end
