$:.unshift File.join File.dirname(__FILE__), "introitus"
%w{ array numeric object }.each {|file| require file}