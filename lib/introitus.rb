class Array
  def sum
    self.flatten.map{|i| begin i.to_f rescue 0.0 end }.inject(&:+)
  end
  
  def to_string
    self.flatten.map{|s| begin s.to_s rescue "" end }.join(" ")
  end
  
  def str_length
    self.to_string.length
  end

  def to_strings_of_length(len=50)
    this = self.dup
    ret = []
    while !this.empty?
      this_str = []
      until this_str.str_length >= len
        this_str << this.shift
      end
      ret << this_str.to_string.strip
    end
    ret
  end
end