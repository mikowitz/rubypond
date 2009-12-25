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
      @phrase.contents.size.should == 7
      @phrase.contents.first.should == Note.new(c4, 4)
      @phrase.contents.last.should == Note.new(bf4, 2)
    end

    it "should return the correct value for :reference_note" do
      @phrase.reference_note.should == Note.new(bf4, 2)
    end
    
    it "should return the correct value for :to_s" do
      @phrase.to_s.should == "c d8 ef16 fs d'8. c, bf'8"
    end
  end

  describe "a short, simple phrase with chords" do
    before do
      @phrase = Phrase.new do
        n c4, 4
        n d4, 2
        n ef4, 1
        n [fs4, g5, a4], 1
        n d5, 3
        n c4, 3
        n bf4, 2
      end
    end

    it "should have the correct size for :contents" do
      @phrase.contents.size.should == 7
      @phrase.contents.first.should == Note.new(c4, 4)
      @phrase.contents.last.should == Note.new(bf4, 2)
    end

    it "should return the correct value for :reference_note" do
      @phrase.reference_note.should == Note.new(bf4, 2)
    end

    it "should return the correct value for :to_s" do
      @phrase.to_s.should == "c d8 ef16 <fs a g'> d'8. c, bf'8"
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
      @phrase.contents.size.should == 21
      @phrase.contents.first.should == Note.new(c4, 4)
      @phrase.contents.last.should == Note.new(bf4, 2)
    end

    it "should return the correct value for :reference_note" do
      @phrase.reference_note.should == Note.new(bf4, 2)
    end
    
    it "should return the correct value for :to_s" do
      @phrase.to_s.should == "c d8 ef16 fs d'8. c, bf'8 c,4 d8 ef16 fs d'8. c, bf'8\nc,4 d8 ef16 fs d'8. c, bf'8"
    end
  end
  
  describe "a short, modularly constructed phrase" do
    before do
      @phrase = Phrase.new
      @phrase.n(c4, 4)
      @phrase.n(d4, 2)
      @phrase.n(e5, 2)
    end
    
    it "should have the correct size for :contents" do
      @phrase.contents.size.should == 3
      @phrase.contents.first.should == Note.new(c4, 4)
      @phrase.contents.last.should == Note.new(e5, 2)
    end
    
    it "should return the correct value for :reference_note" do
      @phrase.reference_note.should == Note.new(e5, 2)
    end
    
    it "should return the correct value for :to_s" do
      @phrase.to_s.should == "c d8 e'"
    end
  end
end