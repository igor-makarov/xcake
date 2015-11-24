require 'xcodeproj'

module Xcake
  module Xcode
    class SchemeList

      attr_accessor :project
      attr_accessor :schemes

      def initialize(project)
        @project = project
        @schemes = []
      end

      def recreate_schemes
        @project.targets.each do |t|
          create_schemes_for_target(t)
        end
      end

      def create_schemes_for_target(target)
        create_schemes_for_application(target)
      end

      def create_schemes_for_application(target)
        target.build_configurations.each do |c|
          scheme = Scheme.new

          scheme.name = "#{target.name}-#{c.name}"
          scheme.add_build_target(target)

          schemes << scheme
        end
      end

      def save(writing_path)

        schemes_dir = Scheme.shared_data_dir(writing_path)
        FileUtils.rm_rf(schemes_dir)
        FileUtils.mkdir_p(schemes_dir)

        xcschememanagement = {}
        xcschememanagement['SchemeUserState'] = {}
        xcschememanagement['SuppressBuildableAutocreation'] = {}

        schemes.each do |s|

          puts "Saving Scheme #{s.name}..."

          scheme.save_as(@project.path, s.name, false)
          xcschememanagement['SchemeUserState']["#{s.name,}.xcscheme"] = {}
          xcschememanagement['SchemeUserState']["#{s.name,}.xcscheme"]['isShown'] = visible
        end

        puts "Saving Scheme List..."

        xcschememanagement_path = schemes_dir + 'xcschememanagement.plist'
        Xcodeproj.write_plist(xcschememanagement, xcschememanagement_path)
      end
    end
  end
end
