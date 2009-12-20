describe "Accidental" do
  describe "\b.from_i" do
    before do 
      @c = Accidental.from_i(0)
      @af = Accidental.from_i(20)
      @cs = Accidental.from_i(25)
    end
    
    it "should return the correct value for 0" do
      @c.should == c
    end

    it "should return the correct value for 20" do
      @af.should == af
    end
    
    it "should return the correct value for 25" do      
      @cs.should == cs
    end
  end

  describe "\b.from" do
    before do
      @d = Accidental.from(2)
      @fs = Accidental.from(18)
      @bf = Accidental.from(34)
    end
    
    it "should return the correct value for 2" do
      @d.should == d
    end

    it "should return the correct value for 18" do
      @fs.should == fs
    end

    it "should return the correct value for 34" do
      @bf.should == bf
    end
  end
  
  it "should have a comparable hierarchy" do
    c.should < cs
    cs.should < df
    f.should > e
    b.should > bf
    bf.should > as
    c.should < b
  end
end