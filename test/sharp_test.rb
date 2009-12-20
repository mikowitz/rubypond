describe "Sharp" do
  before :each do
    @fs = Sharp.new(f)
  end
  
  it "#name should return the correct value" do
    @fs.name.should == "fs"
  end
  
  it "#offset should return the correct value" do
    @fs.offset.should == 6
  end
  
  it "#natural_offest should return the correct value" do
    @fs.natural_offset.should == 5
  end
  
  it "#accidental should return the correct value" do
    @fs.accidental.should == f
  end
  
  it "#sharp should return the correct value" do
    @fs.sharp.should == f.sharp.sharp
  end

  it "#flat should return the correct value" do
    @fs.flat.should == f
  end
  
  it "#natural should return the correct value" do
    @fs.natural.should == f
  end
end