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
    
    it "should have the correct lilypond_display_name" do
      @staff.lilypond_display_name.should == "staff"
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
    
    it "should have the correct lilypond_display_name" do
      @staff.lilypond_display_name.should == "violin"
    end
    
    it "should return the correct data for to_s" do
      @string = @staff.to_s
      @string.should =~ /staff\s\= \\relative c\' \{/
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
          [c3 d3].each do |note|
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
      @staff.instrument_name.should == "Violin II"
    end
    
    it "should have the correct short_instrument_name" do
      @staff.short_instrument_name.should == "Vln II"
    end
    
    it "should have the correct lilypond_display_name" do
      @staff.lilypond_display_name.should == "violinii"
    end
    
    it "should return the correct data for to_s" do
      @string = @staff.to_s
      @string.should =~ /staff\s\= \\relative c \{/
      @string.should =~ /\\set Staff\.instrumentName = \"Viola II\"/
      @string.should =~ /\\set Staff\.shortInstrumentName = \"Vla II\"/
      @string.should =~ /\\clef alto/
      @string.should =~ /c d c d c d c d/
    end
  end
end