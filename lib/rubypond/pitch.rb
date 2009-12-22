module Rubypond
  class Pitch
    include Comparable
    attr_validate :accidental, :octave
    
    def initialize(accidental_or_midi, octave=nil)
      @accidental, @octave = accidental_or_midi, octave
      self.validate
      if @octave.nil?
        @octave = (accidental_or_midi / 12) - 1
        @accidental = Accidental.from_i(accidental_or_midi % 12)
      end
    end
    
    ##
    # @private
    def to_i
      (@octave + 1) * 12 + @accidental.offset
    end

    ##
    # Returns the Lilypond representation of this <tt>Pitch</tt>, relative
    # to either a provided <tt>relative_pitch</tt> or <tt>c4</tt> by default.
    #
    # @param [Pitch] relative_pitch
    # @return [String] Lilypond
    def to_s(relative_pitch=c4)
      octave_change = set_octave_change(relative_pitch)
      if self > relative_pitch
        accidental.name + ("'" * octave_change)
      else
        accidental.name + ("," * octave_change)
      end            
    end
    
    ##
    # Returns the distance in octaves between <tt>self</tt> and <tt>relative_pitch</tt>.
    #
    # @private
    # @param [Pitch] relative_pitch
    # @return [Fixnum] octave_change
    def set_octave_change(relative_pitch)
      natural_distance = set_natural_distance(relative_pitch)
      distance = set_distance(relative_pitch)
      octave_change = distance / 12
      octave_change += 1 if natural_distance >= 7 || (natural_distance.zero? && distance % 12 == 11)
      octave_change
    end

    ##
    # Returns the distance between the <tt>natural</tt> values for <tt>self</tt> and <tt>relative_pitch</tt>.
    #
    # @private
    # @param [Pitch] relative_pitch
    # @return [Fixnum] natural_distance
    def set_natural_distance(relative_pitch)
      [self, relative_pitch].sort.reverse.map{|pitch| pitch.accidental.natural_offset}.inject(&:-) % 12
    end

    ##
    # Returns the distance between <tt>self</tt> and <tt>relative_pitch</tt>.
    #
    # @private
    # @param [Pitch] relative_pitch
    # @return [Fixnum] natural_distance
    def set_distance(relative_pitch)
      [self, relative_pitch].map(&:to_i).sort.reverse.inject(&:-).abs
    end

    ##
    # @private
    def <=>(pitch)
      [self.octave, self.accidental] <=> [pitch.octave, pitch.accidental]
    end
    
    ##
    # Ensures that <tt>accidental</tt> is either a valid <tt>Accidental</tt> or a valid MIDI note value
    #
    # @private
    # @raise [ArgumentError]
    def validate_accidental
      if octave.nil?
        raise(ArgumentError, "Invalid pitch midi value: #{accidental}") unless accidental.is_a?(Fixnum) && accidental.between?(0, 127)
      else
        raise(ArgumentError, "Invalid pitch accidental: #{accidental}") unless accidental.is_a?(Accidental)
      end
    end
    
    ##
    # Ensures that <tt>octave</tt> is between 0 and 9
    #
    # @private
    # @raise [ArgumentError]
    def validate_octave
      raise(ArgumentError, "Invalid pitch octave: #{octave}") if octave && (!octave.is_a?(Fixnum) || !octave.between?(0, 9))
    end
  end
end