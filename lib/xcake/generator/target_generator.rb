module Xcake
  class TargetGenerator < Generator

    def self.dependencies
      [ProjectMetadataGenerator]
    end

    def visit_target(target)
      puts "Creating target #{target.name}..."
      @context.native_object_for(target)
    end
  end
end
