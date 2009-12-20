module Rubypond
  class Sharp < Accidental
    attr_validate :accidental
    
    def initialize(accidental)
      @accidental = accidental
      self.validate
    end
    
    def name; "#{accidental.name}s"; end
    
    def offset; accidental.offset + 1; end
    
    def natural_offset; accidental.offset; end
        
    def sharp; Sharp.new(self); end
    
    alias :flat :accidental
    
    alias :natural :accidental
    
    def validate_accidental
      raise(ArgumentError, "Invalid sharp accidental: #{accidental}") unless accidental.is_a?(Accidental)
    end
  end
end