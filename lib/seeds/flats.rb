%w{ c d e f g a b }.each do |natural|
  eval <<-RUBY
    # @private
    def #{natural}f; Flat.new(#{natural}); end
  RUBY
end