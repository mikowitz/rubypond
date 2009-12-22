require File.dirname(__FILE__) + "/test_helper"

describe "Enumerable" do
  describe "\b#map_with_index" do
    it "should return the correct value for lambda {|obj, index| obj + index}" do
      [1,2,3].map_with_index {|o, i| o + i }.should == [1,3,5]
    end
    
    it "should return the correct value for lambda {|obj, index| obj * index}" do
      [1,2,3].map_with_index {|o, i| o * i }.should == [0,2,6]
    end
    
  end
end