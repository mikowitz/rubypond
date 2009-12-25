require File.dirname(__FILE__) + "/test_helper"

describe "Rubypond" do
  it "should display the correct string in respond to :version" do
    v = File.open(File.join(File.dirname(__FILE__), "..", "VERSION"), "r").readlines.map(&:strip).join("").strip
    Rubypond.version.should == v
  end
  
  describe "\b::INSTRUMENTS" do
    describe "\b' default hash" do
      before do
        @hash = Rubypond::INSTRUMENTS[:no_way_is_this_in_the_hash_keys]
      end
      
      it "should return the correct value for :instrument_name" do
        @hash[:instrument_name].should == "Staff"
      end
      it "should return the correct value for :short_instrument_name" do
        @hash[:short_instrument_name].should == "Staff"
      end
      it "should return the correct value for :display_name" do
        @hash[:display_name].should == "staff"
      end
      it "should return the correct value for :clef" do
        @hash[:clef].should == "treble"
      end
      it "should return the correct value for :relative_c" do
        @hash[:relative_c].should == "c4"
      end
    end

    describe "\b[:violin]" do
      before do
        @hash = Rubypond::INSTRUMENTS[:violin]
      end

      it "should return the correct value for :instrument_name" do
        @hash[:instrument_name].should == "Violin"
      end
      it "should return the correct value for :short_instrument_name" do
        @hash[:short_instrument_name].should == "Vln"
      end
      it "should return the correct value for :display_name" do
        @hash[:display_name].should == "violin"
      end
      it "should return the correct value for :clef" do
        @hash[:clef].should == "treble"
      end
      it "should return the correct value for :relative_c" do
        @hash[:relative_c].should == "c4"
      end      
    end
    
    describe "\b[:cello]" do
      before do
        @hash = Rubypond::INSTRUMENTS[:cello]
      end

      it "should return the correct value for :instrument_name" do
        @hash[:instrument_name].should == "Violoncello"
      end
      it "should return the correct value for :short_instrument_name" do
        @hash[:short_instrument_name].should == "Vlc."
      end
      it "should return the correct value for :display_name" do
        @hash[:display_name].should == "violoncello"
      end
      it "should return the correct value for :clef" do
        @hash[:clef].should == "bass"
      end
      it "should return the correct value for :relative_c" do
        @hash[:relative_c].should == "c3"
      end      
    end
  end
  
  describe "\b.duration" do
    it "should return the correct value for 0.125" do
      Rubypond.duration(0.125).should == "128"
    end
    it "should return the correct value for 0.25" do
      Rubypond.duration(0.25).should == "64"
    end
    it "should return the correct value for 0.5" do
      Rubypond.duration(0.5).should == "32"
    end
    it "should return the correct value for 0.75" do
      Rubypond.duration(0.75).should == "32."
    end
    it "should return the correct value for 1" do
      Rubypond.duration(1).should == "16"
    end
    it "should return the correct value for 2" do
      Rubypond.duration(2).should == "8"
    end
    it "should return the correct value for 3" do
      Rubypond.duration(3).should == "8."
    end
    it "should return the correct value for 4" do
      Rubypond.duration(4).should == "4"
    end
    it "should return the correct value for 6" do
      Rubypond.duration(6).should == "4."
    end
    it "should return the correct value for 7" do
      Rubypond.duration(7).should == "4.."
    end
    it "should return the correct value for 8" do
      Rubypond.duration(8).should == "2"
    end
    it "should return the correct value for 12" do
      Rubypond.duration(12).should == "2."
    end
    it "should return the correct value for 14" do
      Rubypond.duration(14).should == "2.."
    end
    it "should return the correct value for 15" do
      Rubypond.duration(15).should == "2..."
    end
    it "should return the correct value for 16" do
      Rubypond.duration(16).should == "1"
    end
    it "should return the correct value for 24" do
      Rubypond.duration(24).should == "1."
    end
    it "should return the correct value for 28" do
      Rubypond.duration(28).should == "1.."
    end
    it "should return the correct value for 30" do
      Rubypond.duration(30).should == "1..."
    end
    it "should return the correct value for 31" do
      Rubypond.duration(31).should == "1...."
    end
  end
end