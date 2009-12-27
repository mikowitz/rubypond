module Rubypond
  class Score
    ##
    # The name of the file that this <tt>Score</tt> will generate.
    attr_accessor :filename

    # @private
    attr_accessor :parts

    def initialize(score_name="Test Score", &block)
      @filename, @parts = "#{score_name.downcase.gsub(/\s+/, "_")}.ly", []
      instance_eval(&block) if block_given?
    end
    
    ##
    # Adds a <tt>Staff</tt> to the <tt>Score</tt>'s
    # list of staff parts.
    #
    # @private
    # @param [Staff]
    def part(staff)
      @parts << staff
    end
    
    ##
    # Returns the Lilypond string representation
    # of this <tt>Score</tt>.
    #
    # @return [String] Lilypond
    def to_s
      [ lilypond_version_string,
        lilypond_include_string,
        staff_part_strings,
        score_block_string
      ].join("\n")
    end

    ##
    # Generates a .ly file and compiles that into a .pdf
    def build
      write_ly_file
      compile_pdf
    end
    
    # @private
    def write_ly_file
      File.open(filename, "w") do |file|
        file << self.to_s
      end
    end
    
    # @private
    def compile_pdf
      system("lilypond #{filename}")
    end

    # @private
    def lilypond_version_string
      "\\version \"#{Rubypond.lilypond_version}\""
    end
    
    # @private
    def lilypond_include_string
      "\\include \"english.ly\""
    end
    
    # @private
    def staff_part_strings
      [ "\n",
        @parts.map_with_index do |staff, index|
          reference = index == 0 ? nil : @parts[index - 1].reference_note
          staff.to_s(reference)
        end.join("\n\n"),
        "\n"
      ].join("\n")
    end

    # @private
    def score_block_string
      [ score_begin_tag,
        part_score_segments,
        score_end_tag
      ].join("\n")
    end
    
    # @private
    def score_begin_tag
      "\\score {\n<<"
    end
    
    # @private
    def part_score_segments
      @parts.map{|part| part.score_segment}.join("\n")
    end
    
    # @private
    def score_end_tag
      ">>\n}"
    end
  end
end