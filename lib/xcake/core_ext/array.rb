class Array
  def to_h
    Hash[*flatten(1)]
  end
end
