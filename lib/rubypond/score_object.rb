module Rubypond
  ##
  # 'Abstract' class that contains methods for including
  # musical objects (notes, rests, etc.) into an object's
  # <tt>@contents</tt> array.
  module ScoreObject
    ##
    # Add a <tt>Clef</tt> to the object's contents.
    # Params are the same as would be given to <tt>Clef.new</tt>.
    def clef(*args)
      @contents << Clef.new(*args)
    end

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

    ##
    # Add a <tt>TimeSignature</tt> to the object's contents.
    # Params are the same as would be given to <tt>TimeSignature.new</tt>.
    def time(*args)
      @contents << TimeSignature.new(*args)
    end

    def o(ottavation, &block)
      @contents << "\\ottava #{ottavation_string(ottavation)}"
      instance_eval(&block) if block_given?
      @contents << "\\ottava #0"
    end

    def ottavation_string(ottavation)
      case ottavation.to_s
      when "8va" then "#1"
      when "15ma" then "#2"
      when "8vb" then "#-1"
      when "15mb" then "#-2"
      end
    end
  end
end