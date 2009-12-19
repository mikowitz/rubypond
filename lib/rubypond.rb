$:.unshift File.dirname(__FILE__)
$:.unshift File.join File.dirname(__FILE__), "rubypond"

require 'introitus'

module Rubypond
  ##
  # Returns current version of Rubypond
  #
  # @return[String]
  def self.version
    File.open(File.join(File.dirname(__FILE__), "..", "VERSION"), "r").readline.strip
  end
end