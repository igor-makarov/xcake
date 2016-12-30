require 'xcodeproj'

module Xcake
  module Xcode
    # Special subclass of the Xcodeproj::XCScheme which adds capabilities and
    # helper methods xcake need
    #
    class Scheme < Xcodeproj::XCScheme
      # @return  [String] name for the scheme.
      #
      attr_accessor :name
    end
  end
end
