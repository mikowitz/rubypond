require File.dirname(__FILE__) + "/test_helper"

describe "Rubypond" do
  it "should display the correct string in respond to :version" do
    v = File.open(File.join(File.dirname(__FILE__), "..", "VERSION"), "r").readlines.map(&:strip).join("").strip
    Rubypond.version.should == v
  end
  
  describe "\b.duration" do
    it "should return the correct value for 0.125" do
      Rubypond.duration(0.125).should == "128"
    end
    it "should return the correct value for 0.25" do
      Rubypond.duration(0.125).should == "64"
    end
    it "should return the correct value for 0.5" do
      Rubypond.duration(0.125).should == "32"
    end
    it "should return the correct value for 0.75" do
      Rubypond.duration(0.125).should == "32."
    end
    it "should return the correct value for 1" do
      Rubypond.duration(0.125).should == "16"
    end
    it "should return the correct value for 2" do
      Rubypond.duration(0.125).should == "8"
    end
    it "should return the correct value for 3" do
      Rubypond.duration(0.125).should == "8."
    end
    it "should return the correct value for 4" do
      Rubypond.duration(0.125).should == "4"
    end
    it "should return the correct value for 6" do
      Rubypond.duration(0.125).should == "4."
    end
    it "should return the correct value for 7" do
      Rubypond.duration(0.125).should == "4.."
    end
    it "should return the correct value for 8" do
      Rubypond.duration(0.125).should == "2"
    end
    it "should return the correct value for 12" do
      Rubypond.duration(0.125).should == "2."
    end
    it "should return the correct value for 14" do
      Rubypond.duration(0.125).should == "2.."
    end
    it "should return the correct value for 15" do
      Rubypond.duration(0.125).should == "2..."
    end
    it "should return the correct value for 16" do
      Rubypond.duration(0.125).should == "1"
    end
    it "should return the correct value for 24" do
      Rubypond.duration(0.125).should == "1."
    end
    it "should return the correct value for 28" do
      Rubypond.duration(0.125).should == "1.."
    end
    it "should return the correct value for 30" do
      Rubypond.duration(0.125).should == "1..."
    end
    it "should return the correct value for 31" do
      Rubypond.duration(0.125).should == "1...."
    end
  end
end