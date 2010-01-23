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
      _name = self.name
      raise(ArgumentError, "Invalid natural name: #{_name}") unless %w{ c d e f g a b }.include?(_name)
    end

    ##
    # Ensures that <tt>offset</tt> is an integer greater than or equal to 0.
    #
    # @private
    # @raise [ArgumentError]
    def validate_offset
      _offset = self.offset
      raise(ArgumentError, "Invalid natural offset: #{_offset}") unless _offset.is_a?(Fixnum) and _offset >= 0
    end
    
    protected :validate_name, :validate_offset
  end
end