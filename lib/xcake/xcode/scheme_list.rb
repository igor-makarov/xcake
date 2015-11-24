require 'xcodeproj'

module Xcake
  module Xcode
    class SchemeList

      attr_accessor :project

      def initialize(project)
        @project = project
      end

      def recreate_schemes
        @project.targets.each do |t|

          #If Application - Make Schemes for each build configuration and add to build and add unit test target

          create_application_schemes(t)
        end
      end

      def create_application_schemes(target)
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
