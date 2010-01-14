{"c" => 0, "d" => 2, "e" => 4, "f" => 5, "g" => 7, "a" => 9, "b" => 11}.each_pair do |note, offset|
  eval <<-RUBY
    # @private
    def #{note}; Natural.new("#{note}", #{offset}); end
  RUBY
end