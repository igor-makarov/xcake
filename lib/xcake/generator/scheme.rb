require 'xcodeproj'

module Xcake
  module Generator
    class Scheme

      include Visitor

      attr_accessor :context

      # @return [Hash<String, Object>] xcschememanagementfile contents
      #
      #
      attr_accessor :xcschememanagement

      # @return [Array<Scheme>] the schemes in the list
      #
      attr_accessor :schemes

      def initialize(context)
        @context = context
        @schemes = []
        @xcschememanagement = {
          'SchemeUserState' => {},
          'SuppressBuildableAutocreation' => {}
        }
      end

      def visit_project(project)
      end

      def leave_project(project)
          schemes_dir = Xcode::Scheme.user_data_dir(".")

          FileUtils.rm_rf(schemes_dir)
          FileUtils.mkdir_p(schemes_dir)

          schemes.each do |s|

            puts "Saving Scheme #{s.name}..."
            s.save_as(project.path, s.name, true)

            @xcschememanagement['SchemeUserState']["#{s.name}.xcscheme_^#shared#^_"] = {
              "isShown" => true
            }
          end

          puts "Saving Scheme List..."

          xcschememanagement_path = schemes_dir + 'xcschememanagement.plist'
          Xcodeproj.write_plist(@xcschememanagement, xcschememanagement_path)
      end

      #TODO: Test this
      def visit_target(target)
        case target.product_type
          when Xcodeproj::Constants::PRODUCT_TYPE_UTI[:application]
              create_schemes_for_application(target)
        end
      end

      def leave_target(target)
      end

      def visit_configuration(configuration)
      end

      def leave_configuration(configuration)
      end

      # Creates schemes based on a application target
      #
      # @param    [Target] target
      #           target to create application schemes for
      #
      def create_schemes_for_application(target)

        target.build_configurations.each do |c|

          scheme = Xcode::Scheme.new
          scheme.name = "#{target.name}-#{c.name}"

          scheme.configure_with_targets(target, target.testing_target)
          scheme.test_action.build_configuration = c.name
          scheme.launch_action.build_configuration = c.name
          scheme.profile_action.build_configuration = c.name
          scheme.analyze_action.build_configuration = c.name
          scheme.archive_action.build_configuration = c.name

          schemes << scheme

          @xcschememanagement['SuppressBuildableAutocreation'][target.uuid] = {"primary" => true}
          @xcschememanagement['SuppressBuildableAutocreation'][target.testing_target.uuid] = {"primary" => true} if target.testing_target
        end
      end
    end
  end
end
