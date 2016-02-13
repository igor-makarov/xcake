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

  # Strips heredoc indents
  #
  def strip_heredoc
    indent = self.scan(/^[ \t]*(?=\S)/).min
    indent_len = (indent || "").length
    self.gsub(/^[ \t]{#{indent_len}}/, "")
  end
end
