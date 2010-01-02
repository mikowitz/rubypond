module Rubypond
  ##
  # 'Abstract' class that contains methods for including
  # musical objects (notes, rests, etc.) into an object's
  # <tt>@contents</tt> array.
  module ScoreObject

    ##
    # Add a <tt>Note</tt> to the object's contents.
    # Params are the same as would be given to <tt>Note.new</tt>.
    def n(*args)
      @contents << Note.new(*args)
    end

    ##
    # Add a <tt>Rest</tt> to the object's contents.
    # Params are the same as would be given to <tt>Note.Rest</tt>.
    def r(*args)
      @contents << Rest.new(*args)
    end
    
    ##
    # Add an <tt>InvisibleRest</tt> to the object's contents.
    # Params are the same as would be given to <tt>InvisibleRest.new</tt>.
    def s(*args)
      @contents << InvisibleRest.new(*args)
    end
    
    ##
    # Add a <tt>Tuplet</tt> to the object's contents.
    # Params are the same as would be given to <tt>Tuplet.new</tt>.
    def t(*args, &block)
      @contents << Tuplet.new(*args, &block)
    end
  end
end