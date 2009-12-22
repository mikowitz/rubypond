require File.dirname(__FILE__) + "/test_helper"

describe "Enumerable" do
  describe "\b#map_with_index" do
    it "should return the correct value for lambda {|obj, index| obj + index}" do
      [1,2,3].map_with_index {|o, i| o + i }.should == [1,3,5]
    end
    
    it "should return the correct value for lambda {|obj, index| obj * index}" do
      [1,2,3].map_with_index {|o, i| o * i }.should == [0,2,6]
    end
    
    it "should return the correct value when referencing another element in the array" do
      x = [1,2,3]
      foo = x.map_with_index do |o, i|
        o + (x[i + 1] || 0)
      end
      foo.should == [3,5,3]
    end
    
    it "should not change the original array" do
      foo = [1,2,3]
      foo2 = foo.map_with_index{|o, i| o + i}
      foo2.should == [1,3,5]
      foo.should == [1,2,3]
    end
  end
  
  describe "\b#map_with_index!" do
    it "should return the correct value for lambda {|obj, index| obj + index}" do
      [1,2,3].map_with_index! {|o, i| o + i }.should == [1,3,5]
    end
    
    it "should return the correct value for lambda {|obj, index| obj * index}" do
      [1,2,3].map_with_index! {|o, i| o * i }.should == [0,2,6]
    end
    
    it "should return the correct value when referencing another element in the array" do
      x = [1,2,3]
      foo = x.map_with_index! do |o, i|
        o + (x[i + 1] || 0)
      end
      foo.should == [3,5,3]
    end
    
    it "should change the original array" do
      foo = [1,2,3]
      foo2 = foo.map_with_index!{|o, i| o + i}
      foo2.should == [1,3,5]
      foo.should == [1,3,5]
    end
  end
end