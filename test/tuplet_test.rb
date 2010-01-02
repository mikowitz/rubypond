require File.dirname(__FILE__) + "/test_helper"

describe "Tuplet" do
  describe "a new triplet" do
    before do
      @t = Tuplet.new(2,3) {n(c4, 4); n(d4, 2)}
    end
    
    it "should return the correct value for :fraction" do
      @t.fraction.should == "2/3"
    end
    
    it "should return the correct value for :contents" do
      @t.contents.size.should == 2
      @t.contents.first.should == Note.new(c4, 4)
      @t.contents.last.should == Note.new(d4, 2)
    end
    
    it "should return the correct value for :reference_duration" do
      @t.reference_note.should == Note.new(d4, 2)
    end
    
    it "should return the correct value for :to_s" do
      @t.to_s.should == "\\times 2/3 { c d8 }"
    end
  end

  describe "a new duplet" do
    before do
      @t = Tuplet.new(3,2) {n(c4, 2); n(d4, 2)}
    end
    
    it "should return the correct value for :fraction" do
      @t.fraction.should == "3/2"
    end
    
    it "should return the correct value for :contents" do
      @t.contents.size.should == 2
      @t.contents.first.should == Note.new(c4, 2)
      @t.contents.last.should == Note.new(d4, 2)
    end
    
    it "should return the correct value for :reference_duration" do
      @t.reference_note.should == Note.new(d4, 2)
    end
    
    it "should return the correct value for :to_s" do
      @t.to_s.should == "\\times 3/2 { c8 d }"
    end
  end
  
  describe "a new quintuplet" do
    before do
      @t = Tuplet.new(4,5) do
        n c4, 2
        r 2
        n ef4, 4
        r 1
        n d4, 1
      end
    end

    it "should return the correct value for :fraction" do
      @t.fraction.should == "4/5"
    end
    
    it "should return the correct value for :contents" do
      @t.contents.size.should == 5
      @t.contents.first.should == Note.new(c4, 2)
      @t.contents.last.should == Note.new(d4, 1)
    end
    
    it "should return the correct value for :reference_duration" do
      @t.reference_note.should == Note.new(d4, 1)
    end
    
    it "should return the correct value for :to_s" do
      @t.to_s.should == "\\times 4/5 { c8 r ef4 r16 d }"
    end    
  end
end