module Rubypond
  class Natural < Accidental
    attr_validate :name, :offset

    def initialize(name, offset)
      @name, @offset = name, offset
      self.validate
    end
    
    alias :natural_offset :offset
    
    ##
    #
    # @private
    def accidental; self; end
    
    ##
    # Returns a <tt>Sharp</tt> object derived from this <tt>Natural</tt>.
    #
    # @return [Sharp]
    def sharp; Sharp.new(self); end

    ##
    # Returns a <tt>Flat</tt> object derived from this <tt>Natural</tt>.
    #
    # @return [Flat]
    def flat; Flat.new(self); end
    
    alias :natural :accidental
    
    ##
    # Ensures that <tt>name</tt> is a valid natural note name.
    #
    # @private
    # @raise [ArgumentError]
    def validate_name
      raise(ArgumentError, "Invalid natural name: #{name}") unless %w{ c d e f g a b }.include?(name)
    end

    ##
    # Ensures that <tt>offset</tt> is an integer greater than or equal to 0.
    #
    # @private
    # @raise [ArgumentError]
    def validate_offset
      raise(ArgumentError, "Invalid natural offset: #{offset}") unless offset.is_a?(Fixnum) and offset >= 0
    end
    
    protected :validate_name, :validate_offset
  end
end