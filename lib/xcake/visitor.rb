module Xcake
  module Visitor
    def visit(item)
      class_name = item.class.to_s

      class_name.gsub!('Xcake::', '')
      class_name.gsub!('::', '_')

      method = "visit_#{class_name.downcase!}"
      send(method, self)
    end
  end
end
