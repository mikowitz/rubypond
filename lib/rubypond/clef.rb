module Rubypond
  class Clef
    CLEFS = %w{ alto baritone bass percussion tenor treble }
    attr_accessor :reference_note
    attr_validate :clef
    
    def initialize(clef)
      @clef = clef.to_s
      self.validate
    end
    
    def to_s(reference_note=Note.new(c4, 4))
      @reference_note = reference_note
      [ clef_string,
        clef
      ].join(" ")
    end
    
    def clef_string; "\\clef"; end
    
    def validate_clef
      raise(ArgumentError, "Invalid clef: #{clef}") unless CLEFS.include?(clef)
    end
  end
end