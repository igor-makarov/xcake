require 'fiddle'
require 'xcodeproj'

CoreFoundation.module_eval do

    NULL = Fiddle::NULL

    VoidPointer = Fiddle::TYPE_VOIDP
    UInt32 = -Fiddle::TYPE_INT

    CFTypeRef = VoidPointer
    CFTypeRefPointer = VoidPointer
    CFIndex = Fiddle::TYPE_LONG
    CFOptionFlags = UInt32
    CFPropertyListFormatPointer = VoidPointer
    UInt8Pointer = VoidPointer

    KCFPropertyListImmutable = 0

    extern :CFDataCreate, [CFTypeRef, UInt8Pointer, CFIndex], CFTypeRef
    extern :CFPropertyListCreateWithData, [CFTypeRef, CFTypeRef, CFIndex, CFOptionFlags, CFPropertyListFormatPointer, CFTypeRefPointer], CFTypeRef

    def self.RubyStringPropertyListRead(string)

      data = CFDataCreate(NULL,
                          string,
                          string.bytesize)

      error_ptr = CFTypeRefPointer()
      plist = CFPropertyListCreateWithData(NULL,
                                           data,
                                           0,
                                           KCFPropertyListImmutable,
                                           NULL,
                                           error_ptr)
      if plist.null?
        description = CFCopyDescription(error_ptr.ptr)
        raise IOError, "Unable to read plist data: #{description}"
      elsif CFGetTypeID(plist) != CFDictionaryGetTypeID()
        raise TypeError, 'Expected a plist with a dictionary root object.'
      end

      CFDictionaryToRubyHash(plist)
    end
end
