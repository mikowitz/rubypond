describe "Natural" do
  before :each do
    @c = Natural.new("c", 0)
  end
  
  it "#name should return the correct value" do
    @c.name.should == "c"
  end
  
  it "#offset should return the correct value" do
    @c.offset.should == 0
  end
  
  it "#natural_offest should return the correct value" do
    @c.natural_offset.should == 0
  end
  
  it "#accidental should return the correct value" do
    @c.accidental.should == c
  end
  
  it "#sharp should return the correct value" do
    @c.sharp.should == cs
  end

  it "#flat should return the correct value" do
    @c.flat.should == cf
  end
  
  it "#natural should return the correct value" do
    @c.natural.should == c
  end
end