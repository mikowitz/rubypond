describe "Flat" do
  before :each do
    @af = Flat.new(a)
  end
  
  it "#name should return the correct value" do
    @af.name.should == "af"
  end
  
  it "#offset should return the correct value" do
    @af.offset.should == 8
  end
  
  it "#natural_offest should return the correct value" do
    @af.natural_offset.should == 9
  end
  
  it "#accidental should return the correct value" do
    @af.accidental.should == a
  end
  
  it "#sharp should return the correct value" do
    @af.sharp.should == a
  end

  it "#flat should return the correct value" do
    @af.flat.should == a.flat.flat
  end
  
  it "#natural should return the correct value" do
    @af.natural.should == a
  end
end