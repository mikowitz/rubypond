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
    
    def n(*args)
      @contents << Note.new(*args)
    end
    
    def to_s
      [ staff_name_relative_opening,
        staff_instrument_names,
        staff_clef,
        staff_contents,
        staff_closing
      ].join("\n")
    end

    def staff_name_relative_opening
      [display_name, "=", relative_c_string, "{"].join(" ")
    end

    def staff_instrument_names
      [:instrument_name, :short_instrument_name].map do |param|
        "\\set Staff.#{param.to_s.camel_case} = \"#{self.__send__(param)}\""
      end.join("\n")
    end
    
    def staff_clef
      "\\clef #{clef}"
    end
    
    def staff_contents
      temp_objects = [relative_c_note] + @contents
      temp_objects.map_with_index! do |object, index|
        begin temp_objects[index + 1].to_s(object) rescue nil end
      end
      temp_objects.to_strings_of_length.join("\n")
    end
    
    def relative_c_note
      Note.new(eval(relative_c), 4)
    end

    def relative_c_string
      this_c = case relative_c
      when "c4" then "c'"
      when "c3" then "c"
      when "c2" then "c,"
      end
      "\\relative #{this_c}"
    end
    
    def staff_closing; "}"; end
    
    def instrument_name; add_name_extra_to instrument[:instrument_name] ; end
    
    def short_instrument_name; add_name_extra_to instrument[:short_instrument_name]; end

    def display_name; add_name_extra_to(instrument[:display_name], false); end

    def clef; instrument[:clef]; end
    
    def relative_c; instrument[:relative_c]; end
    
    def add_name_extra_to(string, with_space=true)
      separator = with_space ? " " : ""
      extra = with_space ? name_extra : (name_extra || "").downcase
      [string, extra].compact.join(separator)
    end
    
    def class_instrument
      self.class.to_s.downcase.split("::").last.to_sym
    end
  end
end
