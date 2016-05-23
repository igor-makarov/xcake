module Xcake
  def self.modern_xcodeproj?
    defined? Xcodeproj::Plist
  end
end
