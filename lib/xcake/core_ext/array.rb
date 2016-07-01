class Array
  def to_h
    Hash[*self.flatten(1)]
  end
end
