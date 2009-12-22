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
      temp_objects, these_objects = [relative_note] + @contents, []
      temp_objects.each_with_index do |object, index|
        next if index.zero?
        these_objects << object.to_s(temp_objects[index - 1])
      end
      these_objects.to_strings_of_length.join("\n")
    end
  end
end