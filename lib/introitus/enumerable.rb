module Enumerable
  def map_with_index
    index = -1
    self.map{|element| index += 1; yield(element, index)}
  end
end