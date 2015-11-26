require 'xcodeproj'

module Xcake
  module Xcode
    class SchemeList

      attr_accessor :project
      attr_accessor :schemes
      attr_accessor :xcschememanagement

      def initialize(project)
        @project = project
        @schemes = []

        @xcschememanagement = {
          'SchemeUserState' => {},
          'SuppressBuildableAutocreation' => {}
        }
      end

      def recreate_schemes
        @project.targets.each do |t|
          create_schemes_for_target(t)
        end
      end

      def create_schemes_for_target(target)
        case target.product_type
          when Xcodeproj::Constants::PRODUCT_TYPE_UTI[:application]
              create_schemes_for_application(target)
        end
      end

      def create_schemes_for_application(target)
        target.build_configurations.each do |c|
          scheme = Scheme.new

          scheme.name = "#{target.name}-#{c.name}"
          scheme.add_build_target(target)
          @xcschememanagement['SuppressBuildableAutocreation'][target.uuid] = {"primary" => true}

          unit_test_target = project.find_unit_test_target_for_target(target)

          if unit_test_target then
            scheme.add_test_target(unit_test_target)
            unit_test_target.add_dependency(target)
            @xcschememanagement['SuppressBuildableAutocreation'][unit_test_target.uuid] = {"primary" => true}
          end

          schemes << scheme
        end
      end

      def save(writing_path)

        schemes_dir = Scheme.user_data_dir(writing_path)

        FileUtils.rm_rf(schemes_dir)
        FileUtils.mkdir_p(schemes_dir)

        schemes.each do |s|

          puts "Saving Scheme #{s.name}..."
          s.save_as(@project.path, s.name, true)

          @xcschememanagement['SchemeUserState']["#{s.name}.xcscheme_^#shared#^_"] = {}
          @xcschememanagement['SchemeUserState']["#{s.name}.xcscheme_^#shared#^_"]['isShown'] = true
        end

        puts "Saving Scheme List..."

        xcschememanagement_path = schemes_dir + 'xcschememanagement.plist'
        Xcodeproj.write_plist(@xcschememanagement, xcschememanagement_path)
      end
    end
  end
end
