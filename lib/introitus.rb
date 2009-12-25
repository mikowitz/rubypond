$:.unshift File.join File.dirname(__FILE__), "introitus"
%w{ array enumerable numeric object string }.each {|file| require file}