module Rubypond
  class Rest
    attr_validate :duration
    
    # @private
    attr_accessor :reference_note
    
    def initialize(duration)
      @duration = duration
      self.validate
    end
    
    ##
    # Returns a Lilypond representation of this <tt>Rest</tt>,
    # with a duration relative to the previous object.
    #
    # @return [String] Lilypond
    def to_s(relative_note=Note.new(c4, 4))
      @reference_note = Note.new(relative_note.pitches, duration)
      [ rest_notation_char,
        build_duration_string(relative_note.duration)
      ].join("")
    end
    
    # @private
    # @return [String]
    def build_duration_string(this_reference_duration)
      _duration = self.duration
      return "" if _duration == this_reference_duration
      Rubypond.duration(_duration)
    end
    
    # @private
    def rest_notation_char; "r"; end
    
    # @private
    def ==(rest)
      self.duration == rest.duration
    end

    ##
    # Ensures that the <tt>duration</tt> is a valid duration (for now, the smallest allowed duration is 1/128)
    #
    # @private
    # @raise [ArgumentError]
    def validate_duration
      _duration = self.duration
      raise(ArgumentError, "Invalid note duration: #{_duration.inspect}") unless _duration.is_a?(Numeric) && _duration.valid_duration?
    end
    
    protected :validate_duration
  end

  ##
  # In Lilypond, in addition to the regular notated rest, there is
  # a command for an invisible rest that leaves a space in the score, but no
  # visible notation.
  # 
  # @example
  #   InvisibleRest.new(4) #=> "s4"
  class InvisibleRest < Rest
    attr_validate :duration
    
    # @private
    def rest_notation_char; "s"; end
  end
end