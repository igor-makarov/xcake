class Object
  # Returns all descendants of a class
  #
  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end
