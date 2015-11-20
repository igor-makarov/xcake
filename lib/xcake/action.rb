require "fastlane"

module Xcake
    # To share this integration with the other fastlane users:
    # - Fork https://github.com/KrauseFx/fastlane
    # - Clone the forked repository
    # - Move this integration into lib/fastlane/actions
    # - Commit, push and submit the pull request

  class XcakeAction < Fastlane::Action
    def self.run(params)
      # fastlane will take care of reading in the parameter and fetching the environment variable:

      Actions.sh("xcake")
    end

    #####################################################
    # @!group Documentation
    #####################################################

    def self.description
      "A short description with <= 80 characters of what this action does"
    end

    def self.details
      # Optional:
      # this is your change to provide a more detailed description of this action
      "You can use this action to do cool things..."
    end

    def self.available_options
      []
    end

    def self.output
      # Define the shared values you are going to provide
      # Example
      [
        ['XCAKE_CUSTOM_VALUE', 'A description of what this value contains']
      ]
    end

    def self.return_value
      # If you method provides a return value, you can describe here what it does
    end

    def self.authors
      # So no one will ever forget your contribution to fastlane :) You are awesome btw!
      ["Your GitHub/Twitter Name"]
    end

    def self.is_supported?(platform)
      # you can do things like
      #
      #  true
      #
      #  platform == :ios
      #
      #  [:ios, :mac].include?(platform)
      #

      platform == :ios
    end
  end
end
