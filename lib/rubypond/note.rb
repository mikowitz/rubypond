module Rubypond
  class Note
    attr_validate :pitches, :duration
    
    def initialize(pitches, duration)
    end
    
    def to_s(relative_note=Note.new(c4, 4))
    end

    def last_pitch
    end
    
    def last_duration
    end
    
    def validate_pitches
    end
    
    def validate_duration
    end
  end
end