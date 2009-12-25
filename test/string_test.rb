require File.dirname(__FILE__) + "/test_helper"

describe "String" do
  describe "\b#camel_case" do
    before do
      @long_name_one = "long_variable_name"
      @long_name_two = "a_much_longer_method_name"
    end
    
    it "should return the correct result for 'long_variable_name'" do
      @long_name_one.camel_case.should == "longVariableName"
    end
    
    it "should return the correct result for 'a_much_longer_method_name'" do
      @long_name_two.camel_case.should == "aMuchLongerMethodName"
    end
  end
end