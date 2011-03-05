require 'spec_helper'

describe BestTimetableController do
  
  before do
    mock_model('Discipline')
  end

  describe "GET 'new'" do
    it "accesses the Discipline model to find all disciplines on the database" do
      Discipline.should_receive(:all)
      get :new
    end

    it "assigns an instance variable with all the disciplines" do
      all_disciplines = [Factory(:discipline)]
      Discipline.stub(:all).and_return all_disciplines
      get :new
      assigns[:disciplines].should == all_disciplines
    end
  end

end
