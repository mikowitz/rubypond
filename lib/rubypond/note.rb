module Rubypond
  class Note
    attr_validate :pitches, :duration
    
    def initialize(pitches, duration)
      @pitches, @duration = Array(pitches).sort, duration
      self.validate
    end
    
    def to_s(relative_note=Note.new(c4, 4))
      [build_pitch_string(relative_note.reference_pitch), build_duration_string(relative_note.reference_duration)].join("")
    end

    def build_pitch_string(this_reference_pitch)
      if pitches.size == 1
        pitches.first.to_s(this_reference_pitch)
      else
        temp_pitches, these_pitches = [this_reference_pitch] + pitches, []
        temp_pitches.each_with_index do |pitch, i|
          next if i.zero?
          these_pitches << pitch.to_s(temp_pitches[i - 1])
        end
        "<#{these_pitches.join(" ")}>"
      end
    end

    def build_duration_string(this_reference_duration)
      return "" if duration == this_reference_duration
      Rubypond.duration(duration)
    end

    def reference_pitch
      pitches.first
    end
    
    alias :reference_duration :duration
    
    def validate_pitches
      raise(ArgumentError, "Invalid note pitches: #{pitches.inspect}") unless pitches.all?{|pitch| pitch.is_a?(Pitch)}
    end
    
    def validate_duration
      raise(ArgumentError, "Invalid note duration: #{duration.inspect}") unless duration.is_a?(Numeric) && duration > 0 && (duration % 0.125).zero?
    end
  end
end