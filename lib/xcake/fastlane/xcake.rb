require "fastlane"

module Xcake
  module Actions
    module SharedValues
      XCAKE_CUSTOM_VALUE = :XCAKE_CUSTOM_VALUE
    end

    class XcakeAction < Fastlane::Action
      def self.run(params)
        Fastlane::Actions.sh("xcake")
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Create xcode projects easily with Xcake"
      end

      def self.details
        "Runs xcake to generate xcode project's easily"
      end

      def self.available_options
        []
      end

      def self.output
        []
      end

      def self.return_value
      end

      def self.authors
        ["@jcampbell_05"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
