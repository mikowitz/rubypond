require File.dirname(__FILE__) + "/test_helper"

describe "Phrase" do
  describe "a short, simple phrase" do
    before do
      @phrase = Phrase.new do
        n c4, 4
        n d4, 2
        n ef4, 1
        n fs4, 1
        n d5, 3
        n c4, 3
        n bf4, 2
      end
    end
    
    it "should have the correct size for :contents" do
      @phrase.contents.size == 7
      @phrase.contents.first == Note.new(c4, 4)
      @phrase.contents.last == Note.new(bf4, 4)
    end
    
    it "should return the correct value for :to_s" do
      @phrase.to_s.should == "c d8 ef16 fs d'8. c, bf'8"
    end
  end
  
  describe "a longer, simple phrase" do
    before do
      @phrase = Phrase.new do
        3.times {
          n c4, 4
          n d4, 2
          n ef4, 1
          n fs4, 1
          n d5, 3
          n c4, 3
          n bf4, 2
        }
      end
    end

    it "should have the correct size for :contents" do
      @phrase.contents.size == 21
      @phrase.contents.first == Note.new(c4, 4)
      @phrase.contents.last == Note.new(bf4, 4)
    end
    
    it "should return the correct value for :to_s" do
      @phrase.to_s.should == "c d8 ef16 fs d'8. c, bf'8 c,4 d8 ef16 fs d'8. c, bf'8\nc,4 d8 ef16 fs d'8. c, bf'8"
    end
  end
end