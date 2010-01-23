module Rubypond
  ##
  # 'Abstract' class that contains methods for including
  # musical objects (notes, rests, etc.) into an object's
  # <tt>@contents</tt> array.
  module ScoreObject

    ALLOWED_CLEFS = %w{ alto baritone bass percussion tenor treble }
    ##
    # Add a <tt>Clef</tt> to the object's contents.
    #
    # @param [String] clef_name
    def clef(clef_name)
      clef_name = clef_name.to_s
      return unless ALLOWED_CLEFS.include?(clef_name)
      @contents << "\\clef #{clef_name}"
    end

    ALLOWED_MODES = %w{ ionian major dorian phrygian lydian mixolydian aeolian minor locrian }

    def key(note, mode)
      return unless ALLOWED_MODES.include?(mode.to_s)
      @contents << "\\key #{note.name} \\#{mode.to_s}"
    end

    ##
    # Add a <tt>Note</tt> to the object's contents.
    # Params are the same as would be given to <tt>Note.new</tt>.
    def n(*args)
      @contents << Note.new(*args)
    end

    ##
    # Wraps the content in the provided block in an ottavation, which defaults to "8va"
    # Other supported ottavations are: "8vb," "15ma," "15mb."
    #
    # @param [String] ottavation
    def o(ottavation="8va", &block)
      return unless block_given?
      @contents << "\\ottava #{ottavation_string(ottavation)}"
      instance_eval(&block)
      @contents << "\\ottava #0"
    end

    ##
    # Adds a duration space for a pick-up measure
    #
    # @param [Numeric] duration
    def partial(duration)
      @contents << "\\partial #{Rubypond.duration(duration)}"
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
    # Adds a time signature to the object's contents.
    #
    # @example
    #   time(2,4) #=> "\\time 2/4"
    # @params [Integer, Integer] beats, subdivision
    def time(*args)
      @contents << "\\time #{args[0..1].join("/")}"
    end

    # @private
    OTTAVATIONS = {"8va" => "#1", "15ma" => "#2", "8vb" => "#-1", "15mb" => "#-2"}

    # @private
    def ottavation_string(ottavation)
      OTTAVATIONS.fetch(ottavation.to_s) {"#1"}
    end

    # @private
    def method_missing(method, *args, &block)
      @contents << "\\#{method.to_s.camel_case}"
    end
  end
end