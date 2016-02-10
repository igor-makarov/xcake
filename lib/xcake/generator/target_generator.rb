module Xcake
  class TargetGenerator < Generator
    def visit_target(target)
      puts "Creating target #{target.name}..."
      @context.native_object_for(target)
    end
  end
end
