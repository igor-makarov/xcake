require 'xcodeproj'

module CoreFoundation

  extern :CFDataCreate, [CFTypeRef, UInt8Pointer, CFIndex], CFTypeRef
  extern :CFPropertyListCreateWithStream, [CFTypeRef, CFTypeRef, CFIndex, CFOptionFlags, CFPropertyListFormatPointer, CFTypeRefPointer], CFTypeRef

  def self.RubyStringPropertyListRead(string)

    string = RubyStringToCFString(string)
    data = CFDataCreate(NULL,
                        string.to_value,
                        string.size)

    error_ptr = CFTypeRefPointer()
    plist = CFPropertyListCreateWithData(NULL,
                                         data,
                                         0,
                                         KCFPropertyListImmutable,
                                         NULL,
                                         error_ptr)
    CFReadStreamClose(stream)

    if plist.null?
      description = CFCopyDescription(error_ptr.ptr)
      raise IOError, "Unable to read plist data: #{description}"
    elsif CFGetTypeID(plist) != CFDictionaryGetTypeID()
      raise TypeError, 'Expected a plist with a dictionary root object.'
    end

    CFDictionaryToRubyHash(plist)
  end
end
