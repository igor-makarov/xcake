require 'claide'

#TODO: Hook into UI Class somehow.
module Xcake
  class Informative < StandardError
    include CLAide::InformativeError

    def message
      "[!] #{super}".red
    end
  end
end
