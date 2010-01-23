module Rubypond
  class Tuplet
    include ScoreObject
    
    # @private
    attr_accessor :fraction, :contents
    
    def initialize(numerator, denominator, &block)
      @fraction, @contents = "#{numerator}/#{denominator}", []
      instance_eval(&block) if block_given?
    end

    # @private
    def reference_note
      contents.last.reference_note
    end
    
    ##
    # Returns the Lilypond representation of
    # this <tt>Tuplet</tt>.
    #
    # @param [Note]
    # @return [String] Lilypond
    def to_s(reference_note=Note.new(c4, 4))
      [ times_segment,
        fraction,
        tuplet_opening_tag,
        tuplet_contents(reference_note),
        tuplet_closing_tag
      ].join(" ")
    end
    
    # @private
    def times_segment; "\\times"; end
    
    # @private
    def tuplet_opening_tag; "{"; end
    
    # @private
    def tuplet_contents(this_reference_note)
      _these_contents = Rubypond.build_note_or_tuplet_string(@contents, this_reference_note)
      _these_contents
    end
    
    # @private
    def tuplet_closing_tag; "}"; end
  end
  
  ##
  # Subclass of <tt>Tuplet</tt> that has a <tt>fraction</tt> of 3/2
  class Duplet < Tuplet
    def initialize(&block); super(3, 2, &block); end
  end
  
  ##
  # Subclass of <tt>Tuplet</tt> that has a <tt>fraction</tt> of 2/3  
  class Triplet < Tuplet
    def initialize(&block); super(2, 3, &block); end
  end

  ##
  # Subclass of <tt>Tuplet</tt> that has a <tt>fraction</tt> of 4/5
  class Quintuplet < Tuplet
    def initialize(&block); super(4, 5, &block); end
  end
end