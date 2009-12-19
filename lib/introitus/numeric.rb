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