require 'xcodeproj'

module Xcake
  module Xcode
    class Scheme < Xcodeproj::XCScheme
      attr_accessor :name
    end
  end
end
