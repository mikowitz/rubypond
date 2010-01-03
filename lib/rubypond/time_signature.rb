module Rubypond
  class TimeSignature
    attr_validate :beats, :subdivision

    # @private
    attr_accessor :reference_note
    
    def initialize(beats, subdivision)
      @beats, @subdivision = beats, subdivision
      self.validate
    end
    
    ##
    # Returns a Lilypond representation of a <tt>TimeSignature</tt>.
    #
    # @example
    #   TimeSignature(2, 4).new.to_s #=> "\\time 2/4"
    # @param [Note]
    # @return [String]
    def to_s(reference_note=Note.new(c4, 4))
      @reference_note = reference_note
      [ time_string,
        time_fraction
      ].join(" ")
    end

    # @private
    def time_string; "\\time"; end

    # @private
    def time_fraction; "#{beats}/#{subdivision}"; end

    # @private
    def validate_beats
      raise(ArgumentError, "Invalid time signature beats: #{beats}") unless beats.is_a?(Fixnum) and beats >= 0
    end

    # @private
    def validate_subdivision
      raise(ArgumentError, "Invalid time signature subdivision: #{subdivision}") unless subdivision.is_a?(Fixnum) && subdivision.valid_subdiv?
    end
    
    protected :validate_beats, :validate_subdivision
  end
end