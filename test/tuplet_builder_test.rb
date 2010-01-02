require File.dirname(__FILE__) + "/test_helper"

describe "Triplet" do
  describe "a new triplet" do
    before do
      @t = Triplet.new {n(c4, 2); r(2); n(bf4, 2)}
    end

    it "should return the correct value for :fraction" do
      @t.fraction.should == "2/3"
    end
    
    it "should return the correct value for :contents" do
      @t.contents.size.should == 3
      @t.contents.first.should == Note.new(c4, 2)
      @t.contents.last.should == Note.new(bf4, 2)
    end
    
    it "should return the correct value for :reference_duration" do
      @t.reference_note.should == Note.new(bf4, 2)
    end
    
    it "should return the correct value for :to_s" do
      @t.to_s.should == "\\times 2/3 { c8 r bf' }"
    end
  end
end

describe "Quintuplet" do
  describe "a new quintuplet" do
    before do
      @q = Quintuplet.new do
        [c4, d4, e4].each do |pitch|
          n pitch, 1
        end
        n f4, 2
      end
    end
    
    it "should return the correct value for :fraction" do
      @t.fraction.should == "4/5"
    end
    
    it "should return the correct value for :contents" do
      @t.contents.size.should == 4
      @t.contents.first.should == Note.new(c4, 1)
      @t.contents.last.should == Note.new(f4, 2)
    end
    
    it "should return the correct value for :reference_duration" do
      @t.reference_note.should == Note.new(f4, 2)
    end
    
    it "should return the correct value for :to_s" do
      @t.to_s.should == "\\times 4/5 { c16 d e f8 }"
    end    
  end
end