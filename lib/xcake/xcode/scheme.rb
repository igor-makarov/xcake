require 'xcodeproj'

module Xcake
  module Xcode
    class Scheme < Xcodeproj::XCScheme

      # @return  [String] name
      #          name for the scheme.
      #
      attr_accessor :name
    end
  end
end
