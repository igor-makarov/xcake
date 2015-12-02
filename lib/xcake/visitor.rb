module Xcake
  module Visitor

    #TODO: Dry

    def visit(item)
      item_name = item_name(item)

      method = "visit_#{item_name}"
      send(method, item)
    end

    def leave(item)
      item_name = item_name(item)

      method = "leave_#{item_name}"
      send(method, item)
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
