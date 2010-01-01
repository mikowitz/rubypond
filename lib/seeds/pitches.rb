0.upto(9) do |i|
  %w{c d e f g a b c}.each do |p|
    ["", "f", "s"].each do |s|
      eval <<-RUBY
        ##
        #
        # @private
        def #{p}#{s}#{i}
          Pitch.new(#{p}#{s}, #{i})
        end
      RUBY
    end
  end
end