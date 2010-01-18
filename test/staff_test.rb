require File.dirname(__FILE__) + "/test_helper"

describe "Staff" do
  describe "a simple, default staff" do
    before do
      @staff = Staff.new do
        [c4, d4, e4, f4, g4, a4, b4, c5].each do |note|
          n note, 4
        end
      end
    end
    
    it "should contain the correct contents" do
      @staff.contents.size.should == 8
      @staff.contents.first.should == Note.new(c4, 4)
      @staff.contents.last.should == Note.new(c5, 4)
    end
    
    it "should have the correct instrument_name" do
      @staff.instrument_name.should == "Staff"
    end
    
    it "should have the correct short_instrument_name" do
      @staff.short_instrument_name.should == "Staff"
    end

    it "should have the correct display_name" do
      @staff.display_name.should == "staff"
    end

    it "should have the correct score_segment" do
      @staff.score_segment.should == "\\new Staff \\staff"
    end

    it "should return the correct data for to_s" do
      @string = @staff.to_s
      @string.should =~ /staff\s\= \\relative c\' \{/
      @string.should =~ /\\set Staff\.instrumentName = \"Staff\"/
      @string.should =~ /\\set Staff\.shortInstrumentName = \"Staff\"/
      @string.should =~ /\\clef treble/
      @string.should =~ /c d e f g a b c/
    end
  end

  describe "a simple violin staff with rests" do
    before do
      @staff = Oboe.new do
        n c4, 4
        r 3
        n d4, 1
        s 1
        n c4, 1
        r 2
      end
    end
    
    it "should contain the correct contents" do
      @staff.contents.size.should == 6
      @staff.contents.first.should == Note.new(c4, 4)
      @staff.contents.last.should == Rest.new(2)
    end
    
    it "should have the correct instrument_name" do
      @staff.instrument_name.should == "Oboe"
    end
    
    it "should have the correct short_instrument_name" do
      @staff.short_instrument_name.should == "Ob."
    end

    it "should have the correct display_name" do
      @staff.display_name.should == "oboe"
    end

    it "should have the correct score_segment" do
      @staff.score_segment.should == "\\new Staff \\oboe"
    end

    it "should return the correct data for to_s" do
      @string = @staff.to_s
      @string.should =~ /oboe\s\= \\relative c\' \{/
      @string.should =~ /\\set Staff\.instrumentName = \"Oboe\"/
      @string.should =~ /\\set Staff\.shortInstrumentName = \"Ob.\"/
      @string.should =~ /\\clef treble/
      @string.should =~ /c r8. d16 s c r8/
    end
  end  
  
  describe "a simple, violin staff" do
    before do
      @staff = Violin.new do
        [d4, ef4, e4, f4, g4, a4, b4, bf4].each do |note|
          n note, 4
        end
      end
    end
    
    it "should contain the correct contents" do
      @staff.contents.size.should == 8
      @staff.contents.first.should == Note.new(d4, 4)
      @staff.contents.last.should == Note.new(bf4, 4)
    end
    
    it "should have the correct instrument_name" do
      @staff.instrument_name.should == "Violin"
    end
    
    it "should have the correct short_instrument_name" do
      @staff.short_instrument_name.should == "Vln"
    end
    
    it "should have the correct display_name" do
      @staff.display_name.should == "violin"
    end
    
    it "should have the correct score_segment" do
      @staff.score_segment.should == "\\new Staff \\violin"
    end
    
    it "should return the correct data for to_s" do
      @string = @staff.to_s
      @string.should =~ /violin \= \\relative c\' \{/
      @string.should =~ /\\set Staff\.instrumentName = \"Violin\"/
      @string.should =~ /\\set Staff\.shortInstrumentName = \"Vln\"/
      @string.should =~ /\\clef treble/
      @string.should =~ /d ef e f g a b bf/
    end
  end
  
  describe "a simple, second viola staff" do
    before do
      @staff = Viola.new "II" do
        4.times do
          [c3, d3].each do |note|
            n note, 4
          end
        end
      end
    end
    
    it "should contain the correct contents" do
      @staff.contents.size.should == 8
      @staff.contents.first.should == Note.new(c3, 4)
      @staff.contents.last.should == Note.new(d3, 4)
    end
    
    it "should have the correct instrument_name" do
      @staff.instrument_name.should == "Viola II"
    end
    
    it "should have the correct short_instrument_name" do
      @staff.short_instrument_name.should == "Vla II"
    end
    
    it "should have the correct display_name" do
      @staff.display_name.should == "violaii"
    end

    it "should have the correct score_segment" do
      @staff.score_segment.should == "\\new Staff \\violaii"
    end
    
    it "should return the correct data for to_s" do
      @string = @staff.to_s
      @string.should =~ /violaii \= \\relative c' \{/
      @string.should =~ /\\set Staff\.instrumentName = \"Viola II\"/
      @string.should =~ /\\set Staff\.shortInstrumentName = \"Vla II\"/
      @string.should =~ /\\clef alto/
      @string.should =~ /c, d c d c d c d/
    end
  end
  
  describe "a simple, modularly construted oboe part" do
    before do
      @staff = Oboe.new
      4.times do
        [c4, g4].each do |note|
          @staff.n(note, 4)
        end
      end
    end
    
    it "should contain the correct contents" do
      @staff.contents.size.should == 8
      @staff.contents.first.should == Note.new(c4, 4)
      @staff.contents.last.should == Note.new(g4, 4)
    end
    
    it "should have the correct instrument_name" do
      @staff.instrument_name.should == "Oboe"
    end
    
    it "should have the correct short_instrument_name" do
      @staff.short_instrument_name.should == "Ob."
    end
    
    it "should have the correct display_name" do
      @staff.display_name.should == "oboe"
    end

    it "should have the correct score_segment" do
      @staff.score_segment.should == "\\new Staff \\oboe"
    end
    
    it "should return the correct data for to_s" do
      @string = @staff.to_s
      @string.should =~ /oboe \= \\relative c' \{/
      @string.should =~ /\\set Staff\.instrumentName = \"Oboe\"/
      @string.should =~ /\\set Staff\.shortInstrumentName = \"Ob.\"/
      @string.should =~ /\\clef treble/
      @string.should =~ /c g' c, g' c, g' c, g'/
    end
  end
  
  describe "a simple alto part" do
    before do
      @staff = Alto.new "II" do
        [c4, d4, e4, fs4].each do |note|
          n note, 4
        end
        lyrics "Yes, it is I."
      end
    end
  
    it "should contain the correct contents" do
      @staff.contents.size.should == 4
      @staff.contents.first.should == Note.new(c4, 4)
      @staff.contents.last.should == Note.new(fs4, 4)
    end

    it "should have the correct instrument_name" do
      @staff.instrument_name.should == "Alto II"
    end
  
    it "should have the correct short_instrument_name" do
      @staff.short_instrument_name.should == "Alt. II"
    end
  
    it "should have the correct display_name" do
      @staff.display_name.should == "altoii"
    end

    it "should have the correct score_segment" do
      @staff.score_segment.should == "\\new Staff \\altoii"
    end
  
    it "should return the correct data for to_s" do
      @string = @staff.to_s
      @string.should =~ /altoii \= \\relative c' \{/
      @string.should =~ /\\set Staff\.instrumentName = \"Alto II\"/
      @string.should =~ /\\set Staff\.shortInstrumentName = \"Alt. II\"/
      @string.should =~ /c d e fs/
      @string.should =~ /\\addlyrics \{ Yes, it is I. \}/
    end
  end
end