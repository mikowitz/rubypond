module Rubypond
  class Natural < Accidental
    attr_validate :name, :offset

    def initialize(name, offset)
      @name, @offset = name, offset
      self.validate
    end
    
    alias :natural_offset :offset
    
    def accidental; self; end
    
    def sharp; Sharp.new(self); end
    
    def flat; Flat.new(self); end
    
    def natural; self; end
    
    def validate_name
      raise(ArgumentError, "Invalid natural name: #{name}") unless %w{ c d e f g a b }.include?(name)
    end
    
    def validate_offset
      raise(ArgumentError, "Invalid natural offset: #{offset}") unless offset.is_a?(Fixnum) and offset >= 0
    end
  end
end