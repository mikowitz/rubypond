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
  ##
  # Returns the first power of <tt>base</tt> equal to or less than <tt>self</tt>.
  #
  # @param [Fixnum] base
  # @return [Fixnum] power
  def nearest_power_of(base=2)
    power = -10
    power += 1 while self >= base**power
    base**(power-1)
  end

  ##
  # Returns <tt>true</tt> if <tt>self</tt> is a valid musical subdivision (1, 2, 4, 8, etc.),
  # that is, if <tt>self</tt> equals <tt>self.nearest_power_of(2)</tt>.
  # Returns <tt>false</tt> otherwise.
  #
  # @return [boolean]
  def valid_subdiv?
    self.mod_power_of(2).zero?
  end
  
  ##
  # Returns <tt>self</tt> modulo <tt>self.nearest_power_of(base)</tt>.
  #
  # @private
  # @param [Fixnum] base
  # @return [Fixnum] remainder
  def mod_power_of(base=2)
    self % self.nearest_power_of(base)
  end
  
  protected :mod_power_of
end

class Object
  def self.attr_validate *attrs
  end
end