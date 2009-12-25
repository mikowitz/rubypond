class String
  def camel_case
    self.gsub(/\_\w/) {|sub| sub.gsub("_", "").upcase}
  end
end