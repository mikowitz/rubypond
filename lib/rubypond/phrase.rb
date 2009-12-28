module Rubypond
  class Phrase
    include ScoreObject

    # @private
    attr_accessor :contents
    
    def initialize &block
      @contents = []
      instance_eval(&block) if block_given?
    end
    
    ##
    # Returns the <tt>Note</tt> any following object's Lilypond string
    # is calculated relative to.
    #
    # @private
    # @return [Note] reference_note
    def reference_note
      @contents.flatten.last
    end

    ##
    # Returns the Lilypond string representation
    # of the <tt>Phrase</tt>'s <tt>contents</tt> array.
    #
    # @param [Note]
    # @return [String] Lilypond
    def to_s(relative_note=Note.new(c4, 4))
      temp_objects = [relative_note] + @contents
      temp_objects.map_with_index! do |object, index|
        begin temp_objects[index + 1].to_s(object.reference_note) rescue nil end
      end
      temp_objects.compact.to_strings_of_length.join("\n")
    end
  end
end