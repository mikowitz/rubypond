$:.unshift File.dirname(__FILE__)
$:.unshift File.join File.dirname(__FILE__), "rubypond"
$:.unshift File.join File.dirname(__FILE__), "seeds"

require 'introitus'
%w{ score_object accidental flat natural note phrase pitch rest score sharp staff tuplet }.each {|file| require file }

module Rubypond
  BASE_SUBDIVISION_VALUE = 16.0

  ##
  # Returns current version of Rubypond
  #
  # @return [String]
  def self.version
    File.open(File.join(File.dirname(__FILE__), "..", "VERSION"), "r").readline.strip
  end

  ##
  # Returns the latest version of Lilypond currently
  # installed on the user's system.
  #
  # @return [String]
  def self.lilypond_version
    `lilypond --version`.match(/([\d\.]+)/)[0]
  end

  ##
  # Utility function to load Rubypond config files.
  #
  # @private
  def self.load_config_file(filename)
    res = {}
    File.open(File.join(File.dirname(__FILE__), "..", "config", filename), "r") do |file|
      res = YAML.load(file)
    end
    res
  end

  ##
  # The default values for a generic <tt>Staff</tt> object.
  #
  # @private
  def self.instrument_default_staff_values
    @@instrument_default_staff_values ||= Rubypond.load_config_file("default_staff_values.yml")[:default_staff]
  end

  ##
  # Returns the Lilypond representation of a duration lasting
  # <tt>duration</tt> sixteenth notes.
  #
  # @param [Numeric] duration
  # @return [String] Lilypond
  def self.duration(duration)
    duration = duration / BASE_SUBDIVISION_VALUE
    remainder = duration - duration.nearest_power_of
    string = (1/duration.nearest_power_of).to_s
    while remainder > 0
      remainder -= remainder.nearest_power_of
      string += "."
    end
    string
  end

  def self.build_contents_string(objects, relative_note)
    this_reference_note = nil
    objects = [relative_note] + objects
    objects.map_with_index! do |object, index|
      this_reference_note = object.reference_note if object.has_reference_note?
      begin objects[index + 1].to_s(this_reference_note) rescue objects[index + 1].to_s end
    end
    [this_reference_note, objects.compact.to_strings_of_length.join("\n")]
  end

  ORNAMENTS = Rubypond.load_config_file("ornaments.yml")

  STRINGS = Rubypond.load_config_file("instruments/strings.yml")
  WOODWINDS = Rubypond.load_config_file("instruments/woodwinds.yml")
  BRASS = Rubypond.load_config_file("instruments/brass.yml")

  ##
  # A hash of instrument properties: instrument_name, short_instrument_name, display_name, relative_c, and clef.
  INSTRUMENTS = STRINGS.merge(WOODWINDS).merge(BRASS)
  INSTRUMENTS.default = Rubypond.instrument_default_staff_values

  INSTRUMENTS.values.map{|instrument| instrument[:class_name]}.each do |klass_name|
    eval <<-RUBY
      # @private
      class #{klass_name} < Staff
      end
    RUBY
  end
end

##
# Load seed data
%w{ naturals sharps flats pitches }.each {|file| require file}