module Xcake
  def self.is_modern_xcodeproj
    defined? Xcodeproj::Plist
  end
end
