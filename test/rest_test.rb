require File.dirname(__FILE__) + "/test_helper"

describe "Rest" do
  before do
    @r2 = Rest.new(2)
    @r4 = Rest.new(4)
  end
  
  it "should not have a reference_note just after creation" do
    @r2.reference_note.should be_nil
  end
  
  describe "to_s" do
    before do
      @ref1 = Note.new(c4, 4)
      @ref2 = Note.new(c4, 2)
    end
    
    it "should return the correct values with a reference note whose duration is 4" do
      @r2.to_s(@ref1).should == "r8"
      @r4.to_s(@ref1).should == "r"
    end

    it "should return the correct values with a reference note whose duration is 2" do
      @r2.to_s(@ref2).should == "r"
      @r4.to_s(@ref2).should == "r4"
    end
    
    it "should create a value for the rest's :reference_note field" do
      @r2.to_s(@ref2)
      @r2.reference_note.should == Note.new(c4, 2)
    end
  end
  
  describe "validations" do
    [[1,2], {1 => 2}, 0, "12", 0.33333, -5, 0.013].each do |duration|
      it "should raise an ArgumentError when created with #{duration.inspect} as its duration value" do
        lambda { Rest.new(duration) }.should raise_error ArgumentError
      end
    end
  end
end

describe "InvisibleRest" do
  before do
    @s3 = InvisibleRest.new(3)
    @s16 = InvisibleRest.new(16)
  end
  
  it "should not have a reference_note just after creation" do
    @s16.reference_note.should be_nil
  end
  
  describe "to_s" do
    before do
      @ref1 = Note.new(c4, 3)
      @ref2 = Note.new(c4, 16)
    end
    
    it "should return the correct values with a reference note whose duration is 3" do
      @s3.to_s(@ref1).should == "s"
      @s16.to_s(@ref1).should == "s1"
    end

    it "should return the correct values with a reference note whose duration is 16" do
      @s3.to_s(@ref2).should == "s8."
      @s16.to_s(@ref2).should == "s"
    end

    it "should create a value for the rest's :reference_note field" do
      @s3.to_s(@ref2)
      @s3.reference_note.should == Note.new(c4, 3)
    end
  end

  describe "validations" do
    [[1,2], {1 => 2}, 0, "12", 0.33333, -5, 0.013].each do |duration|
      it "should raise an ArgumentError when created with #{duration.inspect} as its duration value" do
        lambda { InvisibleRest.new(duration) }.should raise_error ArgumentError
      end
    end
  end
end