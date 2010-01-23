module Rubypond
  class Flat < Accidental
    attr_validate :accidental
    
    def initialize(accidental)
      @accidental = accidental
      self.validate
    end

    ##
    # Returns the Lilypond representation of this <tt>Flat</tt> object.
    #
    # @return [String]
    def name; "#{accidental.name}f"; end

    ##
    #
    # @private
    def offset; accidental.offset - 1; end
    
    ##
    #
    # @private
    def natural_offset; accidental.offset; end
    
    ##
    # Returns an <tt>Accidental</tt> one semitone higher than this object,
    # which is the same as this object's <tt>accidental</tt>.
    #
    # @return [Accidental]
    def sharp; accidental; end
    
    ##
    # Returns a <tt>Flat</tt> derived from this object.
    #
    # @return [Flat]
    def flat; Flat.new(self); end
    
    alias :natural :accidental
    
    ##
    # Ensures that <tt>accidental</tt> is an <tt>Accidental</tt>
    #
    # @private
    # @raise [ArgumentError]
    def validate_accidental
      _accidental = self.accidental
      raise(ArgumentError, "Invalid flat accidental: #{_accidental}") unless _accidental.is_a?(Accidental)
    end

    protected :validate_accidental
  end
end