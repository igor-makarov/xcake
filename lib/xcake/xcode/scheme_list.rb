require 'xcodeproj'

module Xcake
  module Xcode
    # This class is used to represent a list of Schemes.
    #
    class SchemeList
      # @return [Project] the project for the scheme list
      #
      attr_accessor :project

      # @return [Array<Scheme>] the schemes in the list
      #
      attr_accessor :schemes

      # @return [Hash<String, Object>] xcschememanagementfile contents
      #
      #
      attr_accessor :xcschememanagement

      public

      # @param    [Project] project
      #           project to create scheme list for.
      #
      def initialize(project)
        @project = project
        @schemes = []

        @xcschememanagement = {
          'SchemeUserState' => {},
          'SuppressBuildableAutocreation' => {}
        }
      end

      # Creates the schemes based on the targets.
      #
      def recreate_schemes
        @project.targets.each do |t|
          create_schemes_for_target(t)
        end
      end

      # Creates schemes based on a target.
      #
      # @param    [Target] target
      #           target to create schemes for
      #
      def create_schemes_for_target(target)
        case target.product_type
        when Xcodeproj::Constants::PRODUCT_TYPE_UTI[:application]
          create_schemes_for_application(target)
        end
      end

      # Creates schemes based on a application target
      #
      # @param    [Target] target
      #           target to create application schemes for
      #
      def create_schemes_for_application(target)
        target.build_configurations.each do |c|
          scheme = Scheme.new

          scheme.name = "#{target.name}-#{c.name}"
          @xcschememanagement['SuppressBuildableAutocreation'][target.uuid] = { 'primary' => true }

          #TODO: Add UI Support Here.
          unit_test_target = project.find_unit_test_target_for_target(target)
          scheme.configure_with_targets(target, unit_test_target)

          scheme.test_action.build_configuration = c.name
          scheme.launch_action.build_configuration = c.name
          scheme.profile_action.build_configuration = c.name
          scheme.analyze_action.build_configuration = c.name
          scheme.archive_action.build_configuration = c.name

          # TODO: We should structure this stuff out
          if unit_test_target
            unit_test_target.add_dependency(target)
            @xcschememanagement['SuppressBuildableAutocreation'][unit_test_target.uuid] = { 'primary' => true }
          end

          schemes << scheme
        end
      end

      # Writes scheme list data.
      #
      # @param    [String] writing_path
      #           path to write to.
      #
      # TODO: Move to a Generator
      #
      def save(writing_path)
        schemes_dir = Scheme.user_data_dir(writing_path)

        FileUtils.rm_rf(schemes_dir)
        FileUtils.mkdir_p(schemes_dir)

        schemes.each do |s|
          s.save_as(@project.path, s.name, true)

          @xcschememanagement['SchemeUserState']["#{s.name}.xcscheme_^#shared#^_"] = {
            'isShown' => true
          }
        end

        xcschememanagement_path = schemes_dir + 'xcschememanagement.plist'
        write_plist(xcschememanagement_path)
      end

      private

      def write_plist(xcschememanagement_path)
        if Xcake.modern_xcodeproj?
          Xcodeproj::Plist.write_to_path(@xcschememanagement, xcschememanagement_path)
        else
          Xcodeproj.write_plist(@xcschememanagement, xcschememanagement_path)
        end
      end
    end
  end
end
