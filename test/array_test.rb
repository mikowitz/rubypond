describe "Array" do
  describe "\b#sum" do
    before do
      @arr1 = [1,2,3,4,5]
      @arr2 = [0, -1, 2.5, 4]
      @arr3 = ["1", "hello"]
      @arr4 = [[1,2,3], -6.5, 0.5]
      @arr5 = [{1 => 2}, 1, 5]
    end
    
    it "should return the correct value for @arr1" do
      @arr1.sum.should == 15.0
    end

    it "should return the correct value for @arr2" do
      @arr2.sum.should == 5.5
    end

    it "should return the correct value for @arr3" do
      @arr3.sum.should == 1.0
    end

    it "should return the correct value for @arr4" do
      @arr4.sum.should == 0.0
    end
    
    it "should return the correct value for @arr5" do
      @arr5.sum.should == 6.0
    end
  end
  
  describe "\b#str_length" do
    before do
      @arr1 = [1, 2, "hello", "c4"]
      @arr2 = %w{ x y 17 whatever}
      @arr3 = ["hello", "okgo", 7.5, 0.25]
    end
    
    it "should return the correct value for @arr1" do
      @arr1.str_length.should == 12
    end
    
    it "should return the correct value for @arr2" do
      @arr2.str_length.should == 15
    end
    
    it "should return the correct value for @arr3" do
      @arr3.str_length.should == 19
    end
  end
  
  describe "\b#to_strings_of_length" do
    before do
      @arr1 = %w{hello my name is michael}
      @arr2 = %w{one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty}
    end
    
    it "should return the correct value for @arr1 when length is set to default" do
      @arr1.to_strings_of_length.should == ["hello my name is michael"]
    end
    
    it "should return the correct value for @arr1 when length is set to 10" do
      @arr1.to_strings_of_length(10).should == ["hello my name", "is michael"]
    end
    
    it "should return the correct value for @arr2 when length is set to default" do
      @arr2.to_strings_of_length.should == ["one two three four five six seven eight nine ten eleven", "twelve thirteen fourteen fifteen sixteen seventeen", "eighteen nineteen twenty"]
    end
    
    it "should return the correct value for @arr2 when length is set to 10" do
      @arr2.to_strings_of_length(10).should == ["one two three", "four five six", "seven eight", "nine ten eleven", "twelve thirteen", "fourteen fifteen", "sixteen seventeen", "eighteen nineteen", "twenty"]
    end    
  end
end