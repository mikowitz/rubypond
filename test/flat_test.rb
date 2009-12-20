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
  
  describe "validations" do
    [1, {1 => 2}, [1,2], "hello"].each do |accidental|
      it "should raise an ArgumentError if created with #{accidental.inspect} as an accidental" do
        lambda { Flat.new(accidental) }.should raise_error ArgumentError
      end
    end
  end
end