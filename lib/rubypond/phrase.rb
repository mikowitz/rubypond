module Rubypond
  class Phrase
    attr_accessor :contents
    
    def initialize &block
      @contents = []
      instance_eval(&block)
    end
    
    def n(*args)
      @contents << Note.new(*args)
    end
    
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