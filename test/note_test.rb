require File.dirname(__FILE__) + "/test_helper"

describe "Note" do
  before do
    @c44 = Note.new(c4, 4)
    @c42 = Note.new(c4, 2)
    @d44 = Note.new(d4, 4)
    @a43 = Note.new(a4, 3)
    @c32 = Note.new(c3, 2)
  end

  describe "with a single pitch" do
    before do
      @note = Note.new(c4, 4)
    end
    
    it "should return the correct value for :pitches" do
      @note.pitches.should == [c4]
    end
    
    it "should return the correct value for :duration" do
      @note.duration.should == 4
    end

    it "should return the correct value for :reference_pitch" do
      @note.reference_pitch.should == c4
    end
    
    it "should return the correct value for :reference_duration" do
      @note.reference_duration.should == 4
    end
    
    it "should return the correct_value for :to_s relative to Note.new(c4, 4)" do
      @note.to_s(@c44).should == "c"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(c4, 2)" do
      @note.to_s(@c42).should == "c4"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(d4, 4)" do
      @note.to_s(@d44).should == "c"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(a4, 3)" do
      @note.to_s(@a43).should == "c,4"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(c3, 2)" do
      @note.to_s(@c32).should == "c'4"
    end
  end
  
  describe "with a closed chord" do
    before do
      @note = Note.new([c4, e4, g4], 4)
    end

    it "should return the correct value for :pitches" do
      @note.pitches.should == [c4, e4, g4]
    end
    
    it "should return the correct value for :duration" do
      @note.duration.should == 4
    end

    it "should return the correct value for :reference_pitch" do
      @note.reference_pitch.should == c4
    end
    
    it "should return the correct value for :reference_duration" do
      @note.reference_duration.should == 4
    end
  
    it "should return the correct_value for :to_s relative to Note.new(c4, 4)" do
      @note.to_s(@c44).should == "<c e g>"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(c4, 2)" do
      @note.to_s(@c42).should == "<c e g>4"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(d4, 4)" do
      @note.to_s(@d44).should == "<c e g>"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(a4, 3)" do
      @note.to_s(@a43).should == "<c, e g>4"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(c3, 2)" do
      @note.to_s(@c32).should == "<c' e g>4"
    end
  end
  
  describe "with an open chord" do
    before do
      @note = Note.new([c4, fs5, e5], 2)
    end

    it "should return the correct value for :pitches" do
      @note.pitches.should == [c4, e5, fs5]
    end
    
    it "should return the correct value for :duration" do
      @note.duration.should == 2
    end

    it "should return the correct value for :reference_pitch" do
      @note.reference_pitch.should == c4
    end
    
    it "should return the correct value for :reference_duration" do
      @note.reference_duration.should == 2
    end
  
    it "should return the correct_value for :to_s relative to Note.new(c4, 4)" do
      @note.to_s(@c44).should == "<c e' fs>8"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(c4, 2)" do
      @note.to_s(@c42).should == "<c e' fs>"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(d4, 4)" do
      @note.to_s(@d44).should == "<c e' fs>8"      
    end
    
    it "should return the correct_value for :to_s relative to Note.new(a4, 3)" do
      @note.to_s(@a43).should == "<c, e' fs>8"
    end
    
    it "should return the correct_value for :to_s relative to Note.new(c3, 2)" do
      @note.to_s(@c32).should == "<c' e' fs>"
    end
  end
  
  describe "following a note of the same duration" do
    before do
      @note1 = Note.new(d4, 4)
      @note2 = Note.new(c5, 4)
    end
    
    it "should return the correct value for :to_s for @note1" do
      @note1.to_s(@c44).should == "d"
    end

    it "should return the correct value for :to_s for @note2" do
      @note2.to_s(@c44).should == "c'"
    end
  end

  describe "following a note of a different duration" do
    before do
      @preceding_note = Note.new(c4, 4)
      @note1 = Note.new(c4, 3)
      @note2 = Note.new(c4, 24)
    end
    
    it "should return the correct value for :to_s for @note1" do
      @note1.to_s(@preceding_note).should == "c8."
    end

    it "should return the correct value for :to_s for @note2" do
      @note2.to_s(@preceding_note).should == "c1."
    end    
  end

  describe "following an open chord" do
    before do
      @preceding_note = Note.new([e5, c4, fs6], 4)
      @note1 = Note.new(c5, 6)
      @note2 = Note.new([c3, b3], 2)
    end

    it "should return the correct value for :to_s for @note1" do
      @note1.to_s(@preceding_note).should == "c'4."
    end

    it "should return the correct value for :to_s for @note2" do
      @note2.to_s(@preceding_note).should == "<c, b'>8"
    end
  end
  
  describe "validations" do
    [["2", a4], cs, "ok", [1,2], true, {1 => 2}].each do |pitches|
      it "should raise an ArgumentError when created with #{pitches.inspect} as its pitches value" do
        lambda { Note.new(pitches, 4) }.should raise_error ArgumentError
      end
    end
    
    [[1,2], {1 => 2}, 0, "12", 0.33333, -5, 0.013].each do |duration|
      it "should raise an ArgumentError when created with #{duration.inspect} as its duration value" do
        lambda { Note.new(c4, duration) }.should raise_error ArgumentError
      end
    end
  end
end