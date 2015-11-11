module Xcake
  module Visitor
    def visit(item)
      method = "visit_#{item.class.to_s.downcase!}"
      send method
    end
  end
end
