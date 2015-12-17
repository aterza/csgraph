#
# This is where the extensions to built-in class <tt>Hash</tt> take place
#

class Hash

  #
  # +stringify_keys+
  #
  # returns a copy of the hash with all keys normalized to strings
  #
  def stringify_keys
    res = self.class.new
    self.keys.each { |k| res[k.to_s] = self[k] }
    res
  end

  #
  # +stringify_keys!+
  #
  # in-place version of +stringify_keys+
  #
  def stringify_keys!
    self.keys.each { |k| self[k.to_s] = self.delete(k) unless(k.is_a?(String)) }
    self
  end

end
