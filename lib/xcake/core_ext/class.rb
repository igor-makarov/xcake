module Xcake
  module CoreExtensions
    # @example  Including in a class
    #           extend Xcake::CoreExtensions::ClassDescendants
    #
    module ClassDescendants
      # Returns all descendants of a class
      #
      def descendants
        ObjectSpace.each_object(singleton_class).select { |klass| klass < self }.sort_by(&:to_s)
      end
    end
  end
end
