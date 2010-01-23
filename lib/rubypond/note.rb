module Rubypond
  class Note
    attr_validate :pitches, :duration

    # @private
    attr_accessor :ornaments
    
    def initialize(pitches, duration, *ornaments)
      @pitches, @duration = Array(pitches).sort, duration
      @ornaments = ornaments
      @dynamic = ornaments.find{|ornament| Rubypond::DYNAMICS.include?(ornament.to_s)}
      @tied = ornaments.delete(:~)
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
        build_duration_string(relative_note.reference_duration),
        dynamic_string,
        ornament_string,
        tie_string
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
      _these_pitches = Rubypond.build_note_or_tuplet_string(pitches, this_reference_pitch)
      "<#{_these_pitches}>"
    end
    
    ##
    # Constructs a string representing the duration
    # of this <tt>Note</tt>.
    #
    # @private
    # @param [Numeric] this_reference_duration
    # @return [String] Lilypond
    def build_duration_string(this_reference_duration)
      _duration = self.duration
      return "" if _duration == this_reference_duration
      Rubypond.duration(_duration)
    end

    def dynamic_string
      @dynamic ? "\\#{@dynamic.to_s}" : ""
    end

    ##
    # @private
    def ornament_string
      @ornaments.select{|ornament| Rubypond::ORNAMENTS.keys.include?(ornament)}.
        map{|ornament| Rubypond::ORNAMENTS[ornament]}.join("")
    end

    ##
    # @private
    def tie_string
      tied? ? " ~" : ""
    end

    ##
    # Is this note tied?
    #
    # @private
    # @return [boolean]
    def tied?
      !!@tied
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
      _pitches = self.pitches
      raise(ArgumentError, "Invalid note pitches: #{_pitches.inspect}") unless _pitches.all?{|pitch| pitch.is_a?(Pitch)}
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
    
    protected :validate_pitches, :validate_duration
  end
end