module Rubypond
  class Flat < Accidental
    attr_validate :accidental
    
    def initialize(accidental)
      @accidental = accidental
      self.validate
    end

    def name; "#{accidental.name}f"; end

    def offset; accidental.offset - 1; end
    
    def natural_offset; accidental.offset; end
        
    alias :sharp :accidental
    
    def flat; Flat.new(self); end
    
    alias :natural :accidental
    
    def validate_accidental
      raise(ArgumentError, "Invalid flat accidental: #{accidental}") unless accidental.is_a?(Accidental)
    end
  end
end