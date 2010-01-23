class Array
  ##
  # Collects +self+ into a float total of its elements,
  # returning +0.0+ if an element does not respond to <tt>#to_f</tt>.
  #
  # @return [Float]
  def sum
    self.map{|item| Array(item)}.flatten.map(&:to_f).inject(&:+)
  end

  ##
  # Returns +self+ divded into strings of length equal to
  # or slightly greater than +length+.
  #
  # @param [Fixnum] length the length that each string should be equal or close to
  # @return [Array] the array of strings
  def to_strings_of_length(length=50)
    _this, _ret = self.dup, []
    while !_this.empty?
      _new_str, _this = _this.find_string_of_length(length)
      _ret << _new_str
    end
    _ret
  end
  
  ##
  # Shifts elements from +self+ until their combined length
  # is equal to or slightly greater than +length+.
  #
  # @private
  # @param [Fixnum] length
  # @return [String, Array]
  def find_string_of_length(length=50)
    _this, _new_str = self.dup, []
    until _new_str.str_length >= length
      _new_str << _this.shift
    end
    [_new_str.to_string.strip, _this]
  end
  
  ##
  # Returns the length of <tt>self.to_string</tt>.
  #
  # @private
  # @return [Fixnum]
  def str_length
    self.to_string.length
  end

  ##
  # Joins the elements of +self+ with " ".
  #
  # @private
  # @return [String]
  def to_string
    self.flatten.map(&:to_s).join(" ")
  end

  protected :find_string_of_length, :str_length, :to_string
end