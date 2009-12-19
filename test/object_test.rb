class TestIdError < Exception
end

class TestNameError < Exception
end

class MyTestClass
  attr_validate :id, :name
  
  def initialize(id, name)
    @id, @name = id, name
    self.validate
  end
  
  def validate_id
    raise(TestIdError)if id > 10
  end
  
  def validate_name
    raise TestNameError unless %w{michael erica}.include?(name)
  end
end

describe "MyTestClass" do
  it "should respond to :validations" do
    MyTestClass.should respond_to :validatons
  end
  
  it "should have the correct validations set" do
    MyTestClass.validations.should == [:validate_id, :validate_name]
  end
  
  it "should perform self.validate correctly" do
    lambda { MyTestClass.new(1, "michael") }.should_not raise_error TestIdError
    lambda { MyTestClass.new(1, "michael") }.should_not raise_error TestNameError
    lambda { MyTestClass.new(11, "michael") }.should raise_error TestIdError
    lambda { MyTestClass.new(1, "john") }.should raise_error TestNameError
    lambda { MyTestClass.new(12, "erica") }.should raise_error TestIdError
    lambda { MyTestClass.new(12, "erica") }.should_not raise_error TestNameError
  end
end