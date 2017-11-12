module Xcake
  # This generator generates the build phases for each target
  # in the project
  #
  class TargetBuildRuleGenerator < Generator
    def self.dependencies
      [TargetBuildPhaseGenerator]
    end

    def visit_target(target)
      EventHooks.run_hook :before_adding_build_rules, target

      native_target = @context.native_object_for(target)

      target.build_rules.each do |rule|
        EventHooks.run_hook :before_adding_custom_build_rule, rule, target

        native_build_rule = @context.native_object_for(rule)
        rule.configure_native_build_rule(native_build_rule, @context)
        native_target.build_rules << native_build_rule
      end
    end
  end
end
