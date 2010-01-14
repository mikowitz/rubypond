%w{ c d e f g a b }.each do |natural|
  eval <<-RUBY
    # @private
    def #{natural}s; Sharp.new(#{natural}); end
  RUBY
end