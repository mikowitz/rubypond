module Rubypond
  class Note
    attr_validate :pitches, :duration
    
    def initialize(pitches, duration)
      @pitches, @duration = Array(pitches).sort, duration
      self.validate
    end
    
    ##
    # Returns the Lilypond representation of this <tt>Note</tt>,
    # relative to a provided or default <tt>relative_note</tt>.
    #
    # @param [Note] relative_note
    # @return [String] Lilypond
    def to_s(relative_note=Note.new(c4, 4))
      [
        build_pitch_string(relative_note.reference_pitch),
        build_duration_string(relative_note.reference_duration)
      ].join("")
    end

    ##
    # Constructs a string representing the pitch or pitches
    # that make up this <tt>Note</tt>.
    #
    # @private
    # @param [Pitch] this_reference_pitch
    # @return [String] Lilypond
    def build_pitch_string(this_reference_pitch)
      if pitches.size == 1
        pitches.first.to_s(this_reference_pitch)
      else
        temp_pitches, these_pitches = [this_reference_pitch] + pitches, []
        temp_pitches.each_with_index do |pitch, i|
          next if i.zero?
          these_pitches << pitch.to_s(temp_pitches[i - 1])
        end
        "<#{these_pitches.join(" ")}>"
      end
    end

    ##
    # Constructs a string representing the duration
    # of this <tt>Note</tt>.
    #
    # @private
    # @param [Numeric] this_reference_duration
    # @return [String] Lilypond
    def build_duration_string(this_reference_duration)
      return "" if duration == this_reference_duration
      Rubypond.duration(duration)
    end

    ##
    # The pitch the following <tt>Note</tt>
    # is calculated relative to.
    #
    # @private
    # @return [Pitch]
    def reference_pitch
      pitches.first
    end
    
    alias :reference_duration :duration
    
    ##
    # Ensures that the <tt>pitches</tt> array contains only <tt>Pitch</tt> objects.
    #
    # @private
    # @raise [ArgumentError]
    def validate_pitches
      raise(ArgumentError, "Invalid note pitches: #{pitches.inspect}") unless pitches.all?{|pitch| pitch.is_a?(Pitch)}
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