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
      temp_objects = [relative_note] + @contents
      temp_objects.map_with_index! do |object, index|
        @reference_note = object.reference_note if object.has_reference_note?
        begin temp_objects[index + 1].to_s(@reference_note) rescue temp_objects[index + 1].to_s end
      end
      temp_objects.compact.to_strings_of_length.join("\n")
    end
  end
end