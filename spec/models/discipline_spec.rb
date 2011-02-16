#encoding: utf-8
require 'spec_helper'

describe Discipline do
  let(:valid_params) do
     {:name => "Bases Matemáticas",
      :code => "BC0001",
      :tpi  => "4-0-6"}
  end
  
  before(:each) do
    @discipline = Discipline.new(valid_params)
  end
  
  it "is valid with valid attributes" do
    @discipline.should be_valid
  end
    
  it "isn't valid when tpi isn't on the T-P-I format" do
    @discipline.tpi = "406"
    @discipline.should_not be_valid
  end
    
  describe "#teoric_hours" do
    it "is the 'T' from T-P-I" do
      @discipline.teoric_hours.should == 4
    end
  end
    
  describe "#practical_hours" do
    it "is the 'P' from T-P-I" do
      @discipline.practical_hours.should == 0
    end
  end
    
  describe "#individual_hours" do
    it "is the 'I' from T-P-I" do   
      @discipline.individual_hours.should == 6
    end
  end

end
