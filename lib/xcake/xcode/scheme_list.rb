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

      # Adds target to add instructions
      # to tell xcode not to autocreate scheme for target
      #
      # @param    [Target] target
      #           target to supress autocreation for
      #
      def supress_autocreation_of_target(target)
        @xcschememanagement['SuppressBuildableAutocreation'][target.uuid] = { 'primary' => true }
      end

      # Writes scheme list data.
      #
      def save
        schemes_dir = Scheme.user_data_dir(@project.path)

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
