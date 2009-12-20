module Rubypond
  class Accidental
    include Comparable
    
    ACCIDENTAL_NAMES = %w{ c cs d ef e f fs g af a bf b }
  
    def Accidental.from_i(integer)
      eval(ACCIDENTAL_NAMES[integer.to_i % 12])
    end
    class << self; alias :from :from_i; end

    def <=> accidental
      [self.natural_offset, self.offset] <=> [accidental.natural_offset, accidental.offset]
    end
  end
end