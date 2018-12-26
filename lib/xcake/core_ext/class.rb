module Xcake
  module CoreExtensions
    # @example  Including in a class
    #           Class.send(:include, Xcake::CoreExtensions::ClassDescendants) # done with send because of old ruby versions
    #
    module ClassDescendants
      # Returns all descendants of a class
      #
      def descendants
        ObjectSpace.each_object(singleton_class).select { |klass| klass < self }
      end
    end
  end
end
