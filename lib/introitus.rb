class Array
  ##
  # Collects +self+ into a float total of its elements,
  # returning +0.0+ if an element does not respond to <tt>#to_f</tt>.
  #
  # @return [Float]
  def sum
    self.flatten.map{|item| begin item.to_f rescue 0.0 end }.inject(&:+)
  end

  ##
  # Returns +self+ divded into strings of length equal to
  # or slightly greater than +length+.
  #
  # @param [Fixnum] length the length that each string should be equal or close to
  # @return [Array] the array of strings
  def to_strings_of_length(length=50)
    this, ret = self.dup, []
    while !this.empty?
      new_str, this = this.find_string_of_length(length)
      ret << new_str
    end
    ret
  end
  
  ##
  # Shifts elements from +self+ until their combined length
  # is equal to or slightly greater than +length+.
  #
  # @private
  # @param [Fixnum] length
  # @return [String, Array]
  def find_string_of_length(length=50)
    this, new_str = self.dup, []
    until new_str.str_length >= length
      new_str << this.shift
    end
    [new_str.to_string.strip, this]
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
    self.flatten.map{|item| begin item.to_s rescue "" end }.join(" ")
  end

  protected :find_string_of_length, :str_length, :to_string
end

class Numeric
  def nearest_power_of(x=2)
  end

  def valid_subdiv?
  end
  
  def mod_power_of(x=2)
  end
  
  protected :mod_power_of
end