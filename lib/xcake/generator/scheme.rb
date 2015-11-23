require 'xcodeproj'

module Xcake
  module Generator
    class Scheme

      include Visitor

#TODO: BDD these are stored
      def initialize(project, target)
        @project = project
        @target = target
      end

#TODO: Recreate
    #   def recreate_user_schemes(visible = true)
    #   schemes_dir = XCScheme.user_data_dir(path)
    #   FileUtils.rm_rf(schemes_dir)
    #   FileUtils.mkdir_p(schemes_dir)
    #
    #   xcschememanagement = {}
    #   xcschememanagement['SchemeUserState'] = {}
    #   xcschememanagement['SuppressBuildableAutocreation'] = {}
    #
    #   targets.each do |target|
    #     scheme = XCScheme.new
    #     scheme.add_build_target(target)
    #     scheme.save_as(path, target.name, false)
    #     xcschememanagement['SchemeUserState']["#{target.name}.xcscheme"] = {}
    #     xcschememanagement['SchemeUserState']["#{target.name}.xcscheme"]['isShown'] = visible
    #   end
    #
    #   xcschememanagement_path = schemes_dir + 'xcschememanagement.plist'
    #   Xcodeproj.write_plist(xcschememanagement, xcschememanagement_path)
    # end

      def visit_buildconfiguration(configuration)

      end

      def leave_buildconfiguration(configuration)
      end
    end
  end
end
