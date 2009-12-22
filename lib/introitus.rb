$:.unshift File.join File.dirname(__FILE__), "introitus"
%w{ array enumerable numeric object }.each {|file| require file}