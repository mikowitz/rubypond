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
  
  describe "validations" do
    ["x", 2, [1,2], {1 => 2}, true].each do |name|
      it "should raise an ArgumentError if created with #{name.inspect} as a name" do
        lambda { Natural.new(name, 0) }.should raise_error ArgumentError
      end
    end
    
    [-1, "x", [1,2], {1 => 2}, false, 0.5].each do |offset|
      it "should raise an ArgumentError if created with #{offset.inspect} as an offset" do
        lambda { Natural.new("c", offset) }.should raise_error ArgumentError
      end
    end
  end
end