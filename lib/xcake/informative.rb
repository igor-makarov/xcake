require 'claide'
require 'colored'

# Indicates an user error.
#
# TODO: Move into UI Class
#
module Xcake
  class Informative < StandardError
    include CLAide::InformativeError

    def message
      "[!] #{super}".red
    end
  end
end
