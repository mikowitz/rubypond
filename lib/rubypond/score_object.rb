module Rubypond
  ##
  # 'Abstract' class that contains methods for including
  # musical objects (notes, rests, etc.) into an object's
  # <tt>@contents</tt> array.
  module ScoreObject
    # @private
    def n(*args)
      @contents << Note.new(*args)
    end

    # @private
    def r(*args)
      @contents << Rest.new(*args)
    end
    
    # @private
    def s(*args)
      @contents << InvisibleRest.new(*args)
    end
    
    def t(*args, &block)
      @contents << Tuplet.new(*args, &block)
    end
  end
end