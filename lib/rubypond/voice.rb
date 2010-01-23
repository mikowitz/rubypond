module Rubypond
  class Voice
    include ScoreObject
    attr_accessor :contents, :reference_note
    
    def initialize(parallel=false)
      @parallel, @contents = parallel, []
    end
    
    def to_s(reference_note=nil)
      [
        voices_opening_tag,
        voices_to_s(reference_note),
        voices_closing_tag
      ].join("\n")
    end
    
    # @private
    def voices_to_s(reference_note=nil)
      @reference_note = reference_note
      @contents.map do |phrase|
        final_string, @reference_note = phrase.to_s(@reference_note), phrase.reference_note
        "{ #{final_string} }"
      end.join(non_parallel_break)
    end
    
    # @private
    def voices_opening_tag; "<<"; end
    
    # @private
    def voices_closing_tag; ">>"; end
    
    # @private
    def non_parallel_break
      parallel? ? "\n" : "\n\\\\\n"
    end
    
    # @private
    def parallel?
      !!@parallel
    end
    
    # @private
    ALLOWED_VOICE_METHODS = [:first, :second]
    
    # @private
    def method_missing(method, *args, &block)
      super(method, *args, &block) unless ALLOWED_VOICE_METHODS.include?(method.to_sym)
      return unless block_given?
      phrase = Phrase.new(&block)
      @contents << phrase
      return self
    end
  end
end