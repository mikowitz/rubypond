module Rubypond
  class Staff
    include ScoreObject

    # @private
    attr_accessor :contents, :instrument, :reference_note
    ##
    # Additional name segment to identify individual parts for the same instrument.
    attr_accessor :name_extra
    
    def initialize(name_extra=nil, &block)
      @name_extra, @contents = name_extra, []
      @instrument = Rubypond::INSTRUMENTS[self.class_instrument]
      instance_eval(&block) if block_given?
    end

    ##
    # Returns the Lilypond string representation
    # of the <tt>Staff</tt>'s <tt>contents</tt> array.
    #
    # @return [String] Lilypond
    def to_s(reference_note=nil)
      [ staff_name_relative_opening_tag,
        staff_instrument_names,
        staff_clef,
        staff_contents(reference_note),
        staff_closing_tag
      ].join("\n")
    end

    ##
    # The first line of the <tt>Staff</tt>'s Lilypond representation.
    #
    # @example
    #   staff_name_relative_opening #=> "violin = \relative c' {"
    # @private
    # @return [String] Lilypond
    def staff_name_relative_opening_tag
      [display_name, "=", relative_c_string, "{"].join(" ")
    end


    ##
    # Sets the staff's instrument name and abbreviation.
    #
    # @example
    #   staff_instrument_names #=> '\set Staff.instrumentName = "Violin"\n\set Staff.shortInstrumentName = "Vln"'
    # @private
    # @return [String] Lilypond
    def staff_instrument_names
      [:instrument_name, :short_instrument_name].map do |param|
        staff_instrument_name(param)
      end.join("\n")
    end
    
    # @private
    def staff_instrument_name(name)
      "\\set Staff.#{name.to_s.camel_case} = \"#{self.__send__(name)}\""      
    end
    
    ##
    # Returns a Lilypond representation of the staff's clef.
    #
    # @example
    #   staff_clef #=> "\clef treble"
    # @private
    # @return [String] Lilypond
    def staff_clef
      "\\clef #{instrument_clef}"
    end
    
    ##
    # Converts the <tt>Staff</tt>'s <tt>@contents</tt> array to valid Lilypond.
    #
    # @private
    # @return [String] Lilypond
    def staff_contents(this_reference_note=nil)
      ref_note = Note.new(relative_c_note.pitches, (this_reference_note || relative_c_note).duration)
      @reference_note, final_string = Rubypond.build_contents_string(@contents, ref_note)
      final_string
    end
    
    # @private
    def contents_reference_note(this_reference_note=nil)
      Note.new(contents_reference_note_pitch, contents_reference_note_duration(this_reference_note))
    end

    # @private
    def contents_reference_note_pitch
      relative_c_note.pitches
    end

    # @private
    def contents_reference_note_duration(this_reference_note=nil)
      (this_reference_note || relative_c_note).duration
    end

    ##
    # Returns the <tt>Rubypond</tt> <tt>Note</tt> object
    # that corresponds to the <tt>Staff</tt>'s <tt>relative_c</tt> string.
    #
    # @private
    # @return [Note] relative_c
    def relative_c_note
      Note.new(eval(relative_c), 4)
    end

    # @private
    RELATIVE_C_STRINGS = {"c4" => "c'", "c3" => "c", "c2" => "c,"}

    ##
    # Returns a Lilypond string representation
    # of the <tt>Staff</tt>'s <tt>relative_c</tt> string.
    #
    # @private
    # @return [String] relative_c
    def relative_c_string
      this_c = RELATIVE_C_STRINGS.fetch(relative_c) {"c'"}
      "\\relative #{this_c}"
    end

    ##
    # The string to close a Lilypond part's representation.
    #
    # @private
    # @return [String]
    def staff_closing_tag; "}"; end
    
    ##
    # The staff's instrument name, joined with the name_extra.
    #
    # @private
    # @return [String]
    def instrument_name; add_name_extra_to(instrument[:instrument_name]); end

    ##
    # The staff's instrument name, joined with the name_extra.
    #
    # @private
    # @return [String]
    def short_instrument_name; add_name_extra_to(instrument[:short_instrument_name]); end

    ##
    # The staff's instrument name, joined with the name_extra.
    #
    # @private
    # @return [String]
    def display_name; add_name_extra_to(instrument[:display_name], false); end

    ##
    # The staff's clef.
    #
    # @private
    # @return [String]
    def instrument_clef; instrument[:clef]; end

    ##
    # The staff's relative_c.
    #
    # @private
    # @return [String]    
    def relative_c; instrument[:relative_c]; end

    ##
    # Joins a string to the Staff's name_extra,
    # downcased or with/out a joining space as appropriate
    #
    # @private
    # @param [String, boolean]
    # @return [String]
    def add_name_extra_to(string, with_space=true)
      separator = with_space ? " " : ""
      extra = with_space ? name_extra : (name_extra || "").downcase
      [string, extra].compact.join(separator)
    end

    ##
    # Returns the Lilypond string for how this <tt>Staff</tt>
    # is represented in a Lilypond <tt>score</tt> block.
    #
    # @private
    # @return [String]
    def score_segment
      "\\new Staff \\#{display_name}"
    end
    
    ##
    # The name of the part's instrument, based on the class name.
    #
    # @private
    # @return [Symbol] instrument name
    def class_instrument
      self.class.to_s.downcase.split("::").last.to_sym
    end
  end
end
