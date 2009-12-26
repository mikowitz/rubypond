module Rubypond
  class Rest
    attr_validate :duration

    # @private
    attr_accessor :reference_note
    
    def initialize(duration)
      @duration = duration
      self.validate
    end
    
    def to_s(relative_note=Note.new(c4, 4))
      @reference_note = relative_note
      [ "r",
        build_duration_string(relative_note.duration)
      ].join("")
    end
    
    def build_duration_string(this_reference_duration)
      return "" if duration == this_reference_duration
      Rubypond.duration(duration)
    end
    
    ##
    # Ensures that the <tt>duration</tt> is a valid duration (for now, the smallest allowed duration is 1/128)
    #
    # @private
    # @raise [ArgumentError]
    def validate_duration
      raise(ArgumentError, "Invalid note duration: #{duration.inspect}") unless duration.is_a?(Numeric) && duration > 0 && (duration % 0.125).zero?
    end
  end
end