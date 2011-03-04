require 'spec_helper'

describe Group do
  
  before(:each) do
    @group = Factory(:group)
  end
  
  it "is valid with valid params" do
    @group.should be_valid
  end
  
  it "is invalid without a discipline" do
    @group.discipline = nil
    @group.should_not be_valid
  end
  
  it "is invalid without a name" do
    @group.name = nil
    @group.should_not be_valid
  end
  
  it "is invalid without lessons" do
    @group.lessons = nil
    @group.should_not be_valid
  end
  
end
