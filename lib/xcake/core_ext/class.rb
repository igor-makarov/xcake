module Xcake
  module CoreExtensions
    # Returns all descendants of a class
    #
    def descendants
      ObjectSpace.each_object(singleton_class).select { |klass| klass < self }
    end
  end
end
