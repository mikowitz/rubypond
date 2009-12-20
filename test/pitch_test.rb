require File.dirname(__FILE__) + "/test_helper"

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
      @as5.to_i.should == 82
    end
    
    describe "c4" do
      before do
        @c4 = Pitch.new(c, 4)
      end
      
      it "should return the correct value for to_s relative to c2" do
        c4.to_s(c2).should == "c''"
      end
      
      it "should return the correct value for to_s relative to cs2" do
        c4.to_s(cs2).should == "c''"
      end
      
      it "should return the correct value for to_s relative to d2" do
        c4.to_s(d2).should == "c''"
      end
      
      it "should return the correct value for to_s relative to ef2" do
        c4.to_s(ef2).should == "c''"
      end
      
      it "should return the correct value for to_s relative to e2" do
        c4.to_s(e2).should == "c''"
      end
      
      it "should return the correct value for to_s relative to f2" do
        c4.to_s(f2).should == "c''"
      end
      
      it "should return the correct value for to_s relative to fs2" do
        c4.to_s(fs2).should == "c''"
      end
      
      it "should return the correct value for to_s relative to gf2" do
        c4.to_s(gf2).should == "c'"
      end
      
      it "should return the correct value for to_s relative to g2" do
        c4.to_s(g2).should == "c'"
      end
      
      it "should return the correct value for to_s relative to af2" do
        c4.to_s(af2).should == "c'"
      end
      
      it "should return the correct value for to_s relative to a2" do
        c4.to_s(a2).should == "c'"
      end
      
      it "should return the correct value for to_s relative to bf2" do
        c4.to_s(bf2).should == "c'"
      end
      
      it "should return the correct value for to_s relative to b2" do
        c4.to_s(b2).should == "c'"
      end
      
      it "should return the correct value for to_s relative to c3" do
        c4.to_s(c3).should == "c'"
      end
      
      it "should return the correct value for to_s relative to cs3" do
        c4.to_s(cs3).should == "c'"
      end
      
      it "should return the correct value for to_s relative to d3" do
        c4.to_s(d3).should == "c'"        
      end
      
      it "should return the correct value for to_s relative to ef3" do
        c4.to_s(ef3).should == "c'"        
      end
      
      it "should return the correct value for to_s relative to e3" do
        c4.to_s(e3).should == "c'"        
      end
      
      it "should return the correct value for to_s relative to f3" do
        c4.to_s(f3).should == "c'"
      end
      
      it "should return the correct value for to_s relative to fs3" do
        c4.to_s(fs3).should == "c'"
      end
      
      it "should return the correct value for to_s relative to gf3" do
        c4.to_s(gf3).should == "c"
      end
      
      it "should return the correct value for to_s relative to g3" do
        c4.to_s(g3).should == "c"
      end
      
      it "should return the correct value for to_s relative to af3" do
        c4.to_s(af3).should == "c"
      end
      
      it "should return the correct value for to_s relative to a3" do
        c4.to_s(a3).should == "c"
      end
      
      it "should return the correct value for to_s relative to bf3" do
        c4.to_s(bf3).should == "c"
      end
      
      it "should return the correct value for to_s relative to b3" do
        c4.to_s(b3).should == "c"
      end
      
      it "should return the correct value for to_s relative to c4" do
        c4.to_s(c4).should == "c"
      end
      
      it "should return the correct value for to_s relative to cs4" do
        c4.to_s(cs4).should == "c"
      end
      
      it "should return the correct value for to_s relative to d4" do
        c4.to_s(d4).should == "c"        
      end
      
      it "should return the correct value for to_s relative to ef4" do
        c4.to_s(ef4).should == "c"        
      end
      
      it "should return the correct value for to_s relative to e4" do
        c4.to_s(e4).should == "c"        
      end
      
      it "should return the correct value for to_s relative to f4" do
        c4.to_s(f4).should == "c"
      end
      
      it "should return the correct value for to_s relative to fs4" do
        c4.to_s(fs4).should == "c"
      end
      
      it "should return the correct value for to_s relative to gf4" do
        c4.to_s(gf4).should == "c,"
      end
      
      it "should return the correct value for to_s relative to g4" do
        c4.to_s(g4).should == "c,"
      end
      
      it "should return the correct value for to_s relative to af4" do
        c4.to_s(af4).should == "c,"
      end
      
      it "should return the correct value for to_s relative to a4" do
        c4.to_s(a4).should == "c,"
      end
      
      it "should return the correct value for to_s relative to bf4" do
        c4.to_s(bf4).should == "c,"
      end
      
      it "should return the correct value for to_s relative to b4" do
        c4.to_s(b4).should == "c,"
      end
      
      it "should return the correct value for to_s relative to c5" do
        c4.to_s(c5).should == "c,"
      end      
      
      it "should return the correct value for to_s relative to cs5" do
        c4.to_s(cs5).should == "c,"
      end
      
      it "should return the correct value for to_s relative to d5" do
        c4.to_s(d5).should == "c,"        
      end
      
      it "should return the correct value for to_s relative to ef5" do
        c4.to_s(ef5).should == "c,"        
      end
      
      it "should return the correct value for to_s relative to e5" do
        c4.to_s(e5).should == "c,"        
      end
      
      it "should return the correct value for to_s relative to f5" do
        c4.to_s(f5).should == "c,"
      end
      
      it "should return the correct value for to_s relative to fs5" do
        c4.to_s(fs5).should == "c,"
      end
      
      it "should return the correct value for to_s relative to gf5" do
        c4.to_s(gf5).should == "c,,"
      end
      
      it "should return the correct value for to_s relative to g5" do
        c4.to_s(g5).should == "c,,"
      end
      
      it "should return the correct value for to_s relative to af5" do
        c4.to_s(af5).should == "c,,"
      end
      
      it "should return the correct value for to_s relative to a5" do
        c4.to_s(a5).should == "c,,"
      end
      
      it "should return the correct value for to_s relative to bf5" do
        c4.to_s(bf5).should == "c,,"
      end
      
      it "should return the correct value for to_s relative to b5" do
        c4.to_s(b5).should == "c,,"
      end
      
      it "should return the correct value for to_s relative to c6" do
        c4.to_s(c6).should == "c,,"
      end

      it "should return the correct value for to_s relative to cs6" do
        c4.to_s(cs6).should == "c,,"
      end
    end
    
    describe "fs5" do
      before do
        @fs5 = Pitch.new(fs, 5)
      end

      it "should return the correct value for to_s relative to f2" do
        @fs5.to_s(f2).should == "fs'''"
      end

      it "should return the correct value for to_s relative to fs2" do
        @fs5.to_s(fs2).should == "fs'''"
      end

      it "should return the correct value for to_s relative to g2" do
        @fs5.to_s(g2).should == "fs'''"
      end
      
      it "should return the correct value for to_s relative to f7" do
        @fs5.to_s(f7).should == "fs,,"
      end

      it "should return the correct value for to_s relative to fs7" do
        @fs5.to_s(fs7).should == "fs,,"
      end

      it "should return the correct value for to_s relative to g7" do
        @fs5.to_s(g7).should == "fs,,"
      end
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
        @as5.to_s(d5).should == "as'"
      end
      
      it "should return the correct value for to_s relative to e5" do
        @as5.to_s(e5).should == "as"
      end
      
      it "should return the correct value for to_s relative to e6" do
        @as5.to_s(e6).should == "as,"
      end
      
      it "should return the correct value for to_s relative to e4" do
        @as5.to_s(e4).should == "as'"
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
      @bf4.to_s(e5).should == "bf"
    end
    
    it "should return the correct value for to_s relative to e6" do
      @bf4.to_s(e6).should == "bf,"
    end
  end

  it "should have a comparable hierarchy" do
    c4.should < c5
  end

  # describe "validations" do
  #   [1, "ok", {1 => 2}, [1,2], true].each do |accidental|
  #     it "should raise an ArgumentError when created with #{accidental.inspect} as its accidental" do
  #       lambda { Pitch.new(accidental, 4) }.should raise_error ArgumentError
  #     end
  #   end
  #   
  #   [-1, 4.5, 128, "ok", false, [1,2], {1 => 2}].each do |midi_note|
  #     it "should raise an ArgumentError when created with #{midi_note.inspect} as its midi value" do
  #       lambda { Pitch.new(midi_note) }.should raise_error ArgumentError
  #     end
  #   end
  #   
  #   [-1, 0.5, 10, "ok", true, [1,2], {1 => 2}].each do |octave|
  #     it "should raise an ArgumentError when created wtih #{octave.inspect} as its octave value" do
  #       lambda { Pitch.new(c, octave) }.should raise_error ArgumentError
  #     end
  #   end
  #   
  #   it "should raise an error if the only argument is an accidental" do
  #     lambda { Pitch.new(c) }.should raise_error ArgumentError
  #   end
  # end
end