require 'claide'

# Indicates an user error.
#
module Xcake
  class Informative
    include CLAide::InformativeError

    def message
      "[!] #{super}"
    end
  end
end
