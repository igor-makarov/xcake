require 'xcodeproj'

module Xcake
  module Generator
    class Scheme

      include Visitor

#TODO: BDD this class
      def initialize(project, target)
        @project = project
        @target = target
      end

      def visit_buildconfiguration(configuration)
        scheme = @project.new_scheme
        scheme.add_build_target(@target)
        #     scheme.save_as(path, target.name, false)
        #     xcschememanagement['SchemeUserState']["#{target.name}.xcscheme"] = {}
        #     xcschememanagement['SchemeUserState']["#{target.name}.xcscheme"]['isShown'] = visible
      end

      def leave_buildconfiguration(configuration)
      end
    end
  end
end
