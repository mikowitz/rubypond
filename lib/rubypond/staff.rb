module Rubypond
  class Staff
    # @private
    attr_accessor :contents, :instrument
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
    def to_s
      [ staff_name_relative_opening,
        staff_instrument_names,
        staff_clef,
        staff_contents,
        staff_closing
      ].join("\n")
    end

    ##
    # Adds a <tt>Note</tt> with <tt>*args</tt> arguments
    # to the <tt>Staff</tt>'s <tt>contents</tt> array.
    #
    # @private
    # @param [Pitch, Fixnum]
    def n(*args)
      @contents << Note.new(*args)
    end

    ##
    # The first line of the <tt>Staff</tt>'s Lilypond representation.
    #
    # @example
    #   staff_name_relative_opening #=> "violin = \relative c' {"
    # @private
    # @return [String] Lilypond
    def staff_name_relative_opening
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
        "\\set Staff.#{param.to_s.camel_case} = \"#{self.__send__(param)}\""
      end.join("\n")
    end
    
    ##
    # Returns a Lilypond representation of the staff's clef.
    #
    # @example
    #   staff_clef #=> "\clef treble"
    # @private
    # @return [String] Lilypond
    def staff_clef
      "\\clef #{clef}"
    end
    
    ##
    # Converts the <tt>Staff</tt>'s <tt>@contents</tt> array to valid Lilypond.
    #
    # @private
    # @return [String] Lilypond
    def staff_contents
      temp_objects = [relative_c_note] + @contents
      temp_objects.map_with_index! do |object, index|
        begin temp_objects[index + 1].to_s(object) rescue nil end
      end
      temp_objects.to_strings_of_length.join("\n")
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

    ##
    # Returns a Lilypond string representation
    # of the <tt>Staff</tt>'s <tt>relative_c</tt> string.
    #
    # @private
    # @return [String] relative_c
    def relative_c_string
      this_c = case relative_c
      when "c4" then "c'"
      when "c3" then "c"
      when "c2" then "c,"
      end
      "\\relative #{this_c}"
    end

    ##
    # The string to close a Lilypond part's representation.
    #
    # @private
    # @return [String]
    def staff_closing; "}"; end
    
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
    def clef; instrument[:clef]; end

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