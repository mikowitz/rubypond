class String
  ##
  # Converts a snake-cased string to camel-case.
  #
  # @example Camel-case a string
  #   "a_snake_cased_method_name".camel_case #=> "aSnakeCasedMethodName"
  # @return [String]
  def camel_case
    self.gsub(/\_\w/) {|sub| sub.gsub("_", "").upcase}
  end
end