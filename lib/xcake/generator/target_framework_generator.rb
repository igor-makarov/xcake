module Xcake
  class TargetFrameworkGenerator < Generator
    def self.dependencies
      [TargetGenerator, ConfigurationGenerator]
    end

    def visit_target(target)
      puts "Integrating System Frameworks for #{target}..."

      native_target = @context.native_object_for(target)

      system_frameworks = target.system_frameworks
      native_target.add_system_frameworks(system_frameworks) if system_frameworks
    end
  end
end
