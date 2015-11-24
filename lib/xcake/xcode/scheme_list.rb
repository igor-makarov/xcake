require 'xcodeproj'

module Xcake
  module Xcode
    class SchemeList

      def recreate_schemes_for_project(project)
        project.targets.each do |t|

          
          recreate_schemes_for_target(t, visible)
        end
      end

      def save(writing_path)



        #Do Scheme Stuff Here.

        schemes_dir = Xcodeproj::XCScheme.shared_data_dir(writing_path)
        FileUtils.rm_rf(schemes_dir)
        FileUtils.mkdir_p(schemes_dir)

        xcschememanagement = {}
        xcschememanagement['SchemeUserState'] = {}
        xcschememanagement['SuppressBuildableAutocreation'] = {}

        puts "Saving Scheme List..."

        xcschememanagement_path = schemes_dir + 'xcschememanagement.plist'
        Xcodeproj.write_plist(xcschememanagement, xcschememanagement_path)
      end
    end
  end
end
