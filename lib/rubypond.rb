$:.unshift File.dirname(__FILE__)
$:.unshift File.join File.dirname(__FILE__), "rubypond"

require 'introitus'
%w{ accidental flat natural pitch sharp }.each {|file| require file }

module Rubypond
  ##
  # Returns current version of Rubypond
  #
  # @return[String]
  def self.version
    File.open(File.join(File.dirname(__FILE__), "..", "VERSION"), "r").readline.strip
  end
end

# @private
def c; @@c ||= Natural.new("c", 0); end
# @private
def d; @@d ||= Natural.new("d", 2); end
# @private
def e; @@e ||= Natural.new("e", 4); end
# @private
def f; @@f ||= Natural.new("f", 5); end
# @private
def g; @@g ||= Natural.new("g", 7); end
# @private
def a; @@a ||= Natural.new("a", 9); end
# @private
def b; @@b ||= Natural.new("b", 11); end

# @private
def cs; @@cs ||= Sharp.new(c); end
# @private
def ds; @@ds ||= Sharp.new(d); end
# @private
def es; @@es ||= Sharp.new(e); end
# @private
def fs; @@fs ||= Sharp.new(f); end
# @private
def gs; @@gs ||= Sharp.new(g); end
# @private
def as; @@as ||= Sharp.new(a); end
# @private
def bs; @@bs ||= Sharp.new(b); end

# @private
def cf; @@cf ||= Flat.new(c); end
# @private
def df; @@df ||= Flat.new(d); end
# @private
def ef; @@ef ||= Flat.new(e); end
# @private
def ff; @@ff ||= Flat.new(f); end
# @private
def gf; @@gf ||= Flat.new(g); end
# @private
def af; @@af ||= Flat.new(a); end
# @private
def bf; @@bf ||= Flat.new(b); end

0.upto(9) do |i|
  %w{c d e f g a b c}.each do |p|
    ["", "f", "s"].each do |s|
      eval <<-RUBY
        def #{p}#{s}#{i}
          Pitch.new(#{p}#{s}, #{i})
        end
      RUBY
    end
  end
end