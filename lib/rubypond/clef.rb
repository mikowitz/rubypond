module Rubypond
  class Clef
    AVAILABLE_CLEFS = %w{ alto baritone bass percussion tenor treble }

    # @private
    attr_accessor :reference_note

    attr_validate :clef_name
    
    def initialize(clef_name)
      @clef_name = clef_name.to_s
      self.validate
    end
    
    ##
    # Returns a Lilypond representation of the <tt>Clef</tt>.
    #
    # @example
    #   Clef.new("treble").to_s #=> "\\clef treble"
    #   Clef.new(:alto).to_s    #=> "\\clef alto"
    # @param [Note]
    # @return [String] Lilypond
    def to_s(reference_note=Note.new(c4, 4))
      @reference_note = reference_note
      [ clef_string,
        clef_name
      ].join(" ")
    end
    
    # @private
    def clef_string; "\\clef"; end
    
    # @private
    def validate_clef_name
      raise(ArgumentError, "Invalid clef: #{clef_name}") unless AVAILABLE_CLEFS.include?(clef_name)
    end
    
    protected :validate_clef_name
  end
end