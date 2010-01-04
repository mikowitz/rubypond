require File.dirname(__FILE__) + "/test_helper"

describe "Clef" do
  before do
    @clef1 = Clef.new("treble")
    @clef2 = Clef.new(:tenor)
  end
  
  it "should have the correct value for :clef_name" do
    @clef1.clef_name.should == "treble"
    @clef2.clef_name.should == "tenor"
  end
  
  it "should not have a :reference_note before :to_s is called" do
    @clef1.reference_note.should be_nil
    @clef2.reference_note.should be_nil
  end
  
  it "should return the correct value for :to_s" do
    @clef1.to_s(Note.new(bf2, 6)).should == "\\clef treble"
    @clef2.to_s.should == "\\clef tenor"
  end
  
  it "should have the correct value for :reference_note after calling :to_s" do
    @clef1.reference_note.should == Note.new(bf2, 6)
    @clef2.reference_note.should == Note.new(c4, 4)
  end
  
  describe "validations" do
    ["Treble", "treeble", true, ["treble", "bass"], c4, nil].each do |clef|
      it "should raise an error when when a new Clef is created with clef == #{clef}" do
        lambda {Clef.new(clef)}.should raise_error ArgumentError
      end
    end
  end
end