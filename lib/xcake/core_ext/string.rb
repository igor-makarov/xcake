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
    indent = scan(/^[ \t]*(?=\S)/).min
    indent_len = (indent || '').length
    gsub(/^[ \t]{#{indent_len}}/, '')
  end
end
