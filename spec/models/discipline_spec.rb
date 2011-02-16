#encoding: utf-8
require 'spec_helper'

describe Discipline do
  let(:valid_params) do
     {:name => "Bases Matemáticas",
      :code => "BC0001",
      :tpi  => "4-0-6"}
  end
  
  describe "#tpi" do
    
    it "accepts values on the T-P-I format" do
      discipline = Discipline.new(valid_params)
      discipline.should be_valid
    end
    
    it "doesn't accept values not on the T-P-I format" do
      discipline = Discipline.new(valid_params.merge(:tpi => "406"))
      discipline.should_not be_valid
    end
    
    it "sets the #teoric_hours attribute with the T from T-P-I" do
      discipline = Discipline.new(valid_params)
      discipline.teoric_hours.should == 4
    end
    
    it "sets the #practical_hours attribute with the P from T-P-I" do
      discipline = Discipline.new(valid_params)
      discipline.practical_hours.should == 0
    end
    
    it "sets the #individual_hours attribute with the I from T-P-I" do
      discipline = Discipline.new(valid_params)
      discipline.individual_hours.should == 6
    end
    
  end
end
