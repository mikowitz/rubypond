require File.dirname(__FILE__) + "/test_helper"

describe "Numeric" do
  describe "\b#nearest_power_of" do
    @a = {
      1 => [1],
      2 => [2, 3],
      4 => (4..7).to_a,
      8 => (8..15).to_a,
      16 => [16]
    }
    
    @a.keys.sort.each do |k|
      @a[k].sort.each do |v|
        it "should return the correct value for #{v}" do
          v.nearest_power_of(2).should == k
        end
      end
    end
  end
  
  describe "\b#valid_subdiv?" do
    (1..16).each do |v|
      it "should return the correct value for #{v}" do
        if [1,2,4,8,16].include?(v)
          v.should be_valid_subdiv
        else
          v.should_not be_valid_subdiv
        end
      end
    end
  end
end