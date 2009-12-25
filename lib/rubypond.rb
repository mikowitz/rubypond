$:.unshift File.dirname(__FILE__)
$:.unshift File.join File.dirname(__FILE__), "rubypond"

require 'introitus'
%w{ accidental flat natural note phrase pitch sharp staff }.each {|file| require file }

module Rubypond
  # @private
  STRINGS = YAML.load(File.open(File.dirname(__FILE__) + "/../config/instruments/strings.yml", "r"))
  # @private
  WOODWINDS = YAML.load(File.open(File.dirname(__FILE__) + "/../config/instruments/woodwinds.yml", "r"))
  # @private
  BRASS = YAML.load(File.open(File.dirname(__FILE__) + "/../config/instruments/brass.yml", "r"))

  ##
  # A hash of instrument properties: instrument_name, short_instrument_name, display_name, relative_c, and clef.
  INSTRUMENTS = BRASS.merge(STRINGS).merge(WOODWINDS)
  INSTRUMENTS.default = YAML.load(File.open(File.dirname(__FILE__) + "/../config/default_staff_values.yml", "r"))[:default_staff]

  ##
  # Returns the Lilypond representation of a duration lasting
  # <tt>duration</tt> sixteenth notes.
  #
  # @param [Numeric] duration
  # @return [String] Lilypond
  def self.duration(duration)
    duration = duration / 16.0
    remainder = duration - duration.nearest_power_of
    string = (1/duration.nearest_power_of).to_s
    while remainder > 0
      remainder -= remainder.nearest_power_of
      string += "."
    end
    string
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