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
        build_pitches_string(relative_note.reference_pitch),
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
    def build_pitches_string(this_reference_pitch)
      if pitches.size == 1
        build_single_pitch_string(this_reference_pitch)
      else
        build_chord_string(this_reference_pitch)
      end
    end

    ##
    # Constructs a Lilypond representation of a single pitch
    #
    # @private
    # @param [Pitch] this_reference_pitch
    # @return [String] Lilypond
    def build_single_pitch_string(this_reference_pitch)
      pitches.first.to_s(this_reference_pitch)
    end

    ##
    # Constructs a Lilypond representation of a chord
    #
    # @private
    # @param [Pitch] this_reference_pitch
    # @return [String] Lilypond
    def build_chord_string(this_reference_pitch)
      temp_pitches = [this_reference_pitch] + pitches
      temp_pitches.map_with_index! do |pitch, index|
        begin temp_pitches[index + 1].to_s(pitch) rescue nil end
      end
      "<#{temp_pitches.compact.join(" ")}>"
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
    
    ##
    # The reference note this <tt>Note</tt>
    # passes to the next object. Is equivalent to <tt>self</tt>.
    #
    # @private
    # @return [Note]
    def reference_note
      self
    end

    alias :reference_duration :duration
    
    ##
    # Determines equality of two notes based on pitch collection and duration
    #
    # @private
    # @param [Note]
    # @return [boolean]
    def ==(note)
      [self.pitches, self.duration] == [note.pitches, note.duration]
    end

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
    
    protected :validate_pitches, :validate_duration
  end
end