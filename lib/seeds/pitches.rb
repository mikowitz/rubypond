0.upto(9) do |octave|
  %w{c d e f g a b c}.each do |note_name|
    ["", "f", "s"].each do |modifier|
      eval <<-RUBY
        # @private
        def #{note_name}#{modifier}#{octave}
          Pitch.new(#{note_name}#{modifier}, #{octave})
        end
      RUBY
    end
  end
end