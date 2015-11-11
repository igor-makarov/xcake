#Create way of defining collections or properties that can be Visited

module Xcake
  module Visitable
    def accept(visitor)
      visitor.visit(self)
    end
  end
end
