module Xcake
  # This namespace provides all of methods for
  # implementing the Vistor in the  Visitor pattern.
  #
  # This implementation has a slight twist where
  # a visitor knows when it has "left" an object
  # it is visiting.
  #
  # Classes implementing these methods should
  # add methods `visit_<visitable classname>`
  # and `leave_<visitable classname>` for each
  # visitable they intend to use that class with.
  #
  # @example Implementing Visitor Pattern
  #
  #          class Writer
  #
  #             include Visitor
  #
  #             def visit_page
  #               #Write Page
  #             end
  #
  #             def leave_page
  #               #Append Footer
  #             end
  #          end
  #
  module Visitor
    # This is called when a visitor is visiting a
    # visitable item.
    #
    # By default this method calls the method
    # `visit_<visitable classname>` so make sure
    # you've created a method for each visitable you
    # intend to visit.
    #
    # @param [Visitable] visitable
    #                    the visitable item the visitor is visiting
    #
    def visit(item)
      item_name = item_name(item)

      method = "visit_#{item_name}"
      send(method, item) if respond_to? method
    end

    # This is called when a visitor is leaving a
    # visitable item.
    #
    # By default this method calls the method
    # `leave_<visitable classname>` so make sure
    # you've created a method for each visitable you
    # intend to visit.
    #
    # @param [Visitable] visitable
    #                    the visitable item the visitor has left
    #
    def leave(item)
      item_name = item_name(item)

      method = "leave_#{item_name}"
      send(method, item) if respond_to? method
    end

    private

    def item_name(item)
      class_name = item.class.to_s

      class_name.gsub!('Xcake::', '')
      class_name.gsub!('::', '_')

      class_name.downcase!
    end
  end
end
