class String
  # Escapes string for use with Objective-C
  #
  def to_obj_c
    "\\\@\\\"#{self}\\\""
  end

  # Escapes string for use with C
  #
  def to_c
    "\\\"#{self}\\\""
  end
end
