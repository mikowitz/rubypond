module Rubypond
  class Sharp < Accidental
    attr_validate :accidental
    
    def initialize(accidental)
      @accidental = accidental
      self.validate
    end

    ##
    # Returns the Lilypond representation of this object.
    #
    # @return [String]
    def name; "#{accidental.name}s"; end
    
    ##
    #
    # @private
    def offset; accidental.offset + 1; end
    
    ##
    #
    # @private
    def natural_offset; accidental.offset; end
    
    ##
    # Returns a <tt>Sharp</tt> derived from this object.
    #
    # @return [Sharp]
    def sharp; Sharp.new(self); end
    
    ##
    # Returns an <tt>Accidental</tt> one semitone lower than this object,
    # which is the same as this object's <tt>accidental</tt>.
    #
    # @return [Accidental]
    def flat; accidental; end    
    
    alias :natural :accidental

    ##
    # Ensures that <tt>accidental</tt> is an <tt>Accidental</tt>
    #
    # @private
    # @raise [ArgumentError]
    def validate_accidental
      raise(ArgumentError, "Invalid sharp accidental: #{accidental}") unless accidental.is_a?(Accidental)
    end
    
    protected :validate_accidental
  end
end