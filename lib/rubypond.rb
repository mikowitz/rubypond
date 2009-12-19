$:.unshift File.dirname(__FILE__)
Dir["**/*.rb"].each {|file| require file}