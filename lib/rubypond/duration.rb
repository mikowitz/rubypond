class Rubypond::Duration
  include Comparable

  def initialize(count, subdivision=4)
    @count, @subdivision = count, subdivision
  end

  def <=>(other_duration)
    self.to_decimal <=> other_duration.to_decimal
  end

  def to_decimal
    @count * (1.0 / @subdivision)
  end

  LilypondDurations = {
    1.0 => '1',
    0.5 => '2',
    0.25 => '4',
    0.125 => '8',
    0.0625 => '16'
  }

  def to_ly
    starting_power = 5
    lilypond_string, remainder, power = determine_base_lilypond_duration(starting_power)
    while remainder > 0
      lilypond_string, remainder, power = dotify_duration(lilypond_string, remainder, power)
    end
    lilypond_string
  end

  private

  def dotify_duration(lilypond_string, remainder, current_power)
    lilypond_string += '.'
    current_power -= 1
    remainder -= exp(current_power)
    [lilypond_string, remainder, current_power]
  end

  def determine_base_lilypond_duration(current_power)
    total = self.to_decimal
    current_power -= 1 while exp(current_power) > total
    lilypond_string = LilypondDurations[exp(current_power).to_f]
    remainder = total - exp(current_power)
    [lilypond_string, remainder, current_power]
  end

  def exp(power)
    2 ** power
  end
end
