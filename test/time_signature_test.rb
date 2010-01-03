require File.dirname(__FILE__) + "/test_helper"

describe "TimeSignature" do
  before do
    @ts1 = TimeSignature.new(4,4)
    @ts2 = TimeSignature.new(5, 16)
  end
  
  it "should not have a :reference_note on creation" do
    @ts1.reference_note.should be_nil
  end
  
  it "should return the correct value for :to_s" do
    @ts1.to_s.should == "\\time 4/4"
    @ts2.to_s(Note.new(d3, 1)).should == "\\time 5/16"
  end
  
  it "should have a value for :reference_note after to_s is called" do
    @ts1.reference_note.should == Note.new(c4, 4)
    @ts2.reference_note.should == Note.new(d3, 1)
  end
  
  describe "validations" do
    [-1, 4.5, "a", c4, [1,2], {1 => 2}, false].each do |beats|
      it "should raise an ArgumentError trying to create a TimeSignature with #{beats} as the number of beats" do
        lambda {TimeSignature.new(beats, 4)}.should raise_error ArgumentError
      end
    end

    [-1, 0, 4.5, "a", c4, [1,2], {1 => 2}, 7, 9, true, nil].each do |subdivisions|
      it "should raise an ArgumentError trying to create a TimeSignature with #{subdivisions} as the subdivision value" do
        lambda {TimeSignature.new(4, subdivisions)}.should raise_error ArgumentError
      end
    end    
  end
end