module Rubypond
  class Accidental
    include Comparable
    
    # @private
    ACCIDENTAL_NAMES = %w{ c cs d ef e f fs g af a bf b }
  
    ##
    # Returns the accidental object equivalent to the <tt>(integer % 12)</tt>th
    # element of <tt>Accidental::ACCIDENTAL_NAMES</tt>.
    #
    # @param [Fixnum]
    # @return [Accidental]
    def Accidental.from_i(integer)
      eval(ACCIDENTAL_NAMES[integer.to_i % 12])
    end
    class << self; alias :from :from_i; end

    ##
    # Compares two accidentals based on natural offset and offest.
    # This means that enharmonic equivalents will be ordered based on
    # their natural values.
    #
    # @private
    # @example
    #   "c < b"   #=> "true"
    #   "fs < gf" #=> "true"
    # @param [Accidental] accidental
    # @return [boolean]
    def <=>(accidental)
      [self.natural_offset, self.offset] <=> [accidental.natural_offset, accidental.offset]
    end
  end
end