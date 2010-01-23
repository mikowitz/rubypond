$:.unshift File.dirname(__FILE__)
$:.unshift File.join File.dirname(__FILE__), "rubypond"
$:.unshift File.join File.dirname(__FILE__), "seeds"

require 'introitus'
%w{ score_object accidental flat natural note phrase pitch rest score sharp staff tuplet voice }.each {|file| require file }

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
  # Returns the Lilypond representation of a duration lasting
  # <tt>duration</tt> sixteenth notes.
  #
  # @param [Numeric] duration
  # @return [String] Lilypond
  def self.duration(duration)
    _remainder, _string = Rubypond.prepare_base_duration_string(duration)
    while _remainder > 0
      _remainder, _string = Rubypond.add_dots_to_duration(_remainder, _string)
    end
    _string
  end

  # @private
  def self.prepare_base_duration_string(duration)
    _duration = duration / BASE_SUBDIVISION_VALUE
    _nearest_power_of_duration = _duration.nearest_power_of
    _remainder = _duration - _nearest_power_of_duration
    _string = (1/_nearest_power_of_duration).to_s
    [_remainder, _string]
  end

  # @private
  def self.add_dots_to_duration(remainder, string)
    _remainder = remainder - remainder.nearest_power_of
    _string = "#{string}."
    [_remainder, _string]
  end

  # @private
  def self.build_contents_string(objects, relative_note)
    this_reference_note, _objects = nil, Rubypond.prepare_contents(objects, relative_note)
    _objects.map_with_index! do |object, index|
      this_reference_note = object.reference_note if object.has_reference_note?
      Rubypond.object_to_s(_objects[index + 1], this_reference_note)
    end
    [this_reference_note, Rubypond.final_contents_string(_objects)]
  end
  
  # @private
  def self.final_contents_string(objects)
    objects.compact.to_strings_of_length.join("\n")
  end
  
  # @private
  def self.prepare_contents(objects, relative_note)
    [relative_note] + objects
  end
  
  # @private
  def self.object_to_s(object, reference_note, return_object=object)
    begin object.to_s(reference_note) rescue return_object end
  end
  
  
  def self.build_note_or_tuplet_string(objects, relative_note)
    _objects = Rubypond.prepare_contents(objects, relative_note)
    _objects.map_with_index! do |object, index|
      _reference_object = object.is_a?(Pitch) ? object : object.reference_note
      Rubypond.object_to_s(_objects[index + 1], _reference_object, nil)
    end
    _objects.compact.join(" ")
  end

  ORNAMENTS = Rubypond.load_config_file("ornaments.yml")
  
  DYNAMICS = %w{ ppppp pppp ppp pp p mp mf f ff fff ffff fp sf sff sp spp sfz rfz }

  STRINGS = Rubypond.load_config_file("instruments/strings.yml")
  WOODWINDS = Rubypond.load_config_file("instruments/woodwinds.yml")
  BRASS = Rubypond.load_config_file("instruments/brass.yml")
  VOICES = Rubypond.load_config_file("instruments/voices.yml")

  ##
  # A hash of instrument properties: instrument_name, short_instrument_name, display_name, relative_c, and clef.
  INSTRUMENT_DEFAULT_STAFF_VALUES = Rubypond.load_config_file("default_staff_values.yml")[:default_staff]
  INSTRUMENTS = STRINGS.merge(WOODWINDS).merge(BRASS)
  INSTRUMENTS.default = INSTRUMENT_DEFAULT_STAFF_VALUES

  INSTRUMENTS.values.map{|instrument| instrument[:class_name]}.each do |klass_name|
    eval <<-RUBY
      # @private
      class #{klass_name} < Staff
      end
    RUBY
  end

  VOICES.values.map{|instrument| instrument[:class_name]}.each do |klass_name|
    eval <<-RUBY
      # @private
      class #{klass_name} < VocalStaff
      end
    RUBY
  end
end

##
# Load seed data
%w{ naturals sharps flats pitches }.each {|file| require file}