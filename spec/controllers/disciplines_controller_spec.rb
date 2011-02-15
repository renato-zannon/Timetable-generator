require 'spec_helper'

describe DisciplinesController do

  describe "GET 'new'" do
    it "sets an instance variable with an new discipline" do
      new_discipline = mock_model("Discipline").as_new_record
      Discipline.should_receive(:new).and_return(new_discipline)
      get :new
      assigns[:discipline].should == new_discipline
    end
  end

end
