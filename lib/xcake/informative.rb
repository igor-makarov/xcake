require 'claide'

# Indicates an user error.
#
module Xcake
  class Informative < StandardError
    include CLAide::InformativeError

    def message
      "[!] #{super}"
    end
  end
end
