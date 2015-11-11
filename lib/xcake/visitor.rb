module Xcake
  module Visitor

    #TODO: Dry

    def visit(item)
      class_name = item.class.to_s

      class_name.gsub!('Xcake::', '')
      class_name.gsub!('::', '_')

      method = "visit_#{class_name.downcase!}"
      send(method, item)
    end

    def leave(item)
      class_name = item.class.to_s

      class_name.gsub!('Xcake::', '')
      class_name.gsub!('::', '_')

      method = "leave_#{class_name.downcase!}"
      send(method, item)
    end
  end
end
