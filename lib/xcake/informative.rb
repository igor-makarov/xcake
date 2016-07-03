require 'claide'

module Xcake
  class Informative < StandardError
    include CLAide::InformativeError
  end
end
