module Rubypond
  class Phrase
    include ScoreObject

    # @private
    attr_accessor :contents, :reference_note
    
    def initialize &block
      @contents = []
      instance_eval(&block) if block_given?
    end
    
    ##
    # Returns the Lilypond string representation
    # of the <tt>Phrase</tt>'s <tt>contents</tt> array.
    #
    # @param [Note]
    # @return [String] Lilypond
    def to_s(relative_note=Note.new(c4, 4))
      @reference_note, final_string = Rubypond.build_contents_string(@contents, relative_note)
      final_string
    end
  end
end