module Enumerable
  ##
  # Calls block with two arguments, the <tt>object</tt> and its index, 
  # for each <tt>object</tt> in the <tt>Enumerable</tt>.
  #
  # @param [Proc]
  # @return [Array]
  def map_with_index
    index = -1
    self.map{|element| index += 1; yield(element, index)}
  end

  ##
  # Same as <tt>#map_with_index</tt>, but replaces <tt>self</tt>
  # with the result.
  #
  # @param [Proc]
  # @return [Array]
  def map_with_index! &block
    res = self.map_with_index(&block)
    replace(res)
  end
end