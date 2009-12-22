module Rubypond
  class Phrase
    # @private
    attr_accessor :contents
    
    def initialize &block
      @contents = []
      instance_eval(&block)
    end
    
    ##
    # Adds a <tt>Note</tt> with <tt>*args</tt> arguments
    # to the <tt>Phrase</tt>'s <tt>contents</tt> array.
    #
    # @private
    # @param [Pitch, Fixnum]
    def n(*args)
      @contents << Note.new(*args)
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
        begin temp_objects[index + 1].to_s(object) rescue nil end
      end
      temp_objects.to_strings_of_length.join("\n")
    end
  end
end