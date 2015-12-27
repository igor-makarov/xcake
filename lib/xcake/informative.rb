require 'claide'

# Indicates an user error.
#
class Informative
  include CLAide::InformativeError

  def message
    "[!] #{super}"
  end
end
