require 'xcodeproj'

module CoreFoundation
  def self.RubyStringPropertyListRead(string)
    url = CFURLCreateFromFileSystemRepresentation(NULL,
                                                  path,
                                                  path.bytesize,
                                                  FALSE)
    stream = CFReadStreamCreateWithFile(NULL, url)
    unless CFReadStreamOpen(stream) == TRUE
      raise IOError, 'Unable to open stream.'
    end

    error_ptr = CFTypeRefPointer()
    plist = CFPropertyListCreateWithStream(NULL,
                                           stream,
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
