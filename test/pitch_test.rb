describe "Pitch" do
  describe "created with an accidental and octave" do
    before do
      @c3 = Pitch.new(c, 3)
      @as5 = Pitch.new(as, 5)
    end
    
    it "should return the correct value for #accidental" do
      @c3.accidental.should == c
      @as5.accidental.should == as
    end
    
    it "should return the correct value for #octave" do
      @c3.octave.should == 3
      @as5.octave.should == 5
    end
    
    it "should return the correct value for to_i" do
      @c3.to_i.should == 48
      @as5.to_i.should == 106
    end
    
    describe "c3" do
      it "should return the correct value for to_s relative to c4" do
        @c3.to_s.should == "c,"
      end
      
      it "should return the correct value for to_s relative to d3" do
        @c3.to_s(d3).should == "c"
      end
      
      it "should return the correct value for to_s relative to fs3" do
        @c3.to_s(fs3).should == "c"
      end
      
      it "should return the correct value for to_s relative to gf3" do
        @c3.to_s(gf3).should == "c,"
      end
      
      it "should return the correct value for to_s relative to fs2" do
        @c3.to_s(fs2).should == "c'"
      end

      it "should return the correct value for to_s relative to gf2" do
        @c3.to_s(gf2).should == "c"
      end
    end
    
    describe "as5" do
      it "should return the correct value for to_s relative to c4" do
        @as5.to_s.should == "as''"
      end
      
      it "should return the correct value for to_s relative to d5" do
        @as5.to_s(d).should == "as'"
      end
      
      it "should return the correct value for to_s relative to e5" do
        @as5.to_s(e5).should == "as"
      end
      
      it "should return the correct value for to_s relative to e6" do
        @as5.to_s(e6).should == "as,"
      end
    end
  end
  
  describe "created with a midi value" do
    before do
      @bf4 = Pitch.new(70)
    end
    
    it "should return the correct value for #accidental" do
      @bf4.accidental.should == bf
    end
    
    it "should return the correct value for #octave" do
      @bf4.octave.should == 4
    end
    
    it "should return the correct value for #to_i" do
      @bf4.to_i.should == 70
    end
    
    it "should return the correct value for to_s relative to c4" do
      @bf4.to_s.should == "bf'"
    end

    it "should return the correct value for to_s relative to c5" do
      @bf4.to_s(c5).should == "bf"
    end

    it "should return the correct value for to_s relative to e4" do
      @bf4.to_s(e4).should == "bf'"
    end

    it "should return the correct value for to_s relative to e5" do
      @bf4.to_s.should == "bf"
    end
  end

  describe "validations" do
    [1, "ok", {1 => 2}, [1,2], true].each do |accidental|
      it "should raise an ArgumentError when created with #{accidental.inspect} as its accidental" do
        lambda { Pitch.new(accidental, 4) }.should raise_error ArgumentError
      end
    end
    
    [-1, 4.5, 128, "ok", false, [1,2], {1 => 2}].each do |midi_note|
      it "should raise an ArgumentError when created with #{midi_note.inspect} as its midi value" do
        lambda { Pitch.new(midi_note) }.should raise_error ArgumentError
      end
    end
    
    [-1, 0.5, 10, "ok", true, [1,2], {1 => 2}].each do |octave|
      it "should raise an ArgumentError when created wtih #{octave.inspect} as its octave value" do
        lambda { Pitch.new(c, octave) }.should raise_error ArgumentError
      end
    end
    
    it "should raise an error if the only argument is an accidental" do
      lambda { Pitch.new(c) }.should raise_error ArgumentError
    end
  end
end