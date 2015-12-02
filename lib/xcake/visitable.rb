module Xcake
  # This namespace provides all of methods for
  # implementing the Visitable in the  Visitor pattern.
  #
  module Visitable
    # This method accepts the visitors.
    #
    # The default implementatio lets the
    # visitor visit then leave.
    #
    # Override this if you need to allow
    # visitors to visit properties of a
    # class.
    #
    # @param [Visitor] visitor
    #                  the visitor to accept
    #
    def accept(visitor)
      visitor.visit(self)
      visitor.leave(self)
    end
  end
end
