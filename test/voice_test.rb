require File.dirname(__FILE__) + "/test_helper"

describe "Voice" do
  describe "with non parallel parts" do
    before do
      @voice = Voice.new.first do
        n c4, 4
        r 8
        n d4, 4
      end.second do
        n c3, 8
        n e3, 3
        n f3, 3
        n d3, 2
      end
    end
  
    it "should have the correct contents" do
      @voice.contents.size.should == 2
      @voice.contents[0].first.size.should == 3
      @voice.contents[1].first.size.should == 4
    end
    
    it "should return the correct data for to_s" do
      @string = @voice.to_s
      @string.should =~ /\{ c r2 d4 \}/
      @string.should =~ /\\\\/
      @string.should =~ /\{ c,2 e8. f8. d8 \}/
    end
    
    it "should return the correct reference_note" do
      @voice.reference_note.should = Note.new(d3, 2)
    end
  end
  
  describe "with parallel parts" do
    before do
      @voice = Voice.new(true).first do
        n c4, 4
        r 8
        n d4, 4
      end.second do
        n c3, 4
        r 8
        n a3, 4
      end
    end
  
    it "should have the correct contents" do
      @voice.contents.size.should == 2
      @voice.contents[0].first.size.should == 3
      @voice.contents[1].first.size.should == 3
    end
    
    it "should return the correct data for to_s" do
      @string = @voice.to_s
      @string.should =~ /\{ c r2 d4 \}/
      @string.should_not =~ /\\\\/
      @string.should =~ /\{ c, r2 a'4 \}/
    end
    
    it "should return the correct reference_note" do
      @voice.reference_note.should = Note.new(a3, 4)
    end
  end
end