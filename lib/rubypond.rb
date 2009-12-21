$:.unshift File.dirname(__FILE__)
$:.unshift File.join File.dirname(__FILE__), "rubypond"

require 'introitus'
%w{ accidental flat natural pitch sharp }.each {|file| require file }

module Rubypond
  def self.duration(duration)

  end

  ##
  # Returns current version of Rubypond
  #
  # @return [String]
  def self.version
    File.open(File.join(File.dirname(__FILE__), "..", "VERSION"), "r").readline.strip
  end
end

# @private
def c; Natural.new("c", 0); end
# @private
def d; Natural.new("d", 2); end
# @private
def e; Natural.new("e", 4); end
# @private
def f; Natural.new("f", 5); end
# @private
def g; Natural.new("g", 7); end
# @private
def a; Natural.new("a", 9); end
# @private
def b; Natural.new("b", 11); end

# @private
def cs; Sharp.new(c); end
# @private
def ds; Sharp.new(d); end
# @private
def es; Sharp.new(e); end
# @private
def fs; Sharp.new(f); end
# @private
def gs; Sharp.new(g); end
# @private
def as; Sharp.new(a); end
# @private
def bs; Sharp.new(b); end

# @private
def cf; Flat.new(c); end
# @private
def df; Flat.new(d); end
# @private
def ef; Flat.new(e); end
# @private
def ff; Flat.new(f); end
# @private
def gf; Flat.new(g); end
# @private
def af; Flat.new(a); end
# @private
def bf; Flat.new(b); end

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