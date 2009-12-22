module Enumerable
  ##
  # Returns a new array with the results of running
  # the given block once for each object and its
  # position in the <tt>Enumerable</tt>.
  #
  # @param [Proc]
  # @return [Array]
  def map_with_index
    index = -1
    self.map{|element| index += 1; yield(element, index)}
  end
end