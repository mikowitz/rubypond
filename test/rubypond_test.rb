describe "Rubypond" do
  it "should display the correct string in respond to :version" do
    v = File.open(File.join(File.dirname(__FILE__), "..", "VERSION"), "r").readlines.map(&:strip).join("").strip
    Rubypond.version.should == v
  end
end