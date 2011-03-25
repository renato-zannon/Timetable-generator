require 'spec_helper'

describe BestTimetableController do
  
  before(:all) do
#    BestTimetable = 
  end

  before do
    mock_model('Discipline')
    BestTimetable ||= mock('BestTimetable')
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

  describe "POST 'generate'" do
    before do
      BestTimetable.stub(:generate)
    end

    let(:codes) do
      {"BC0001" => 1,
      "BC0002" => 1,
      "BC0003" => 1}
    end

    it "retrieves the disciplines based on the codes it receives" do
      codes.each_key { |code| Discipline.should_receive(:find_by_code).with(code) }
      post :generate, :disciplines => codes
    end

    context "when it finds no disciplines" do
      before do
        Discipline.stub(:find_by_code).and_return nil
        post :generate
      end

      it "sets a flash[error] message" do
        flash[:error].should =~ /nenhuma disciplina/i
      end

      it "redirects to the 'new' action" do
        response.should redirect_to :action => :new
      end
    end

    context "when it finds disciplines" do
      before do
        Discipline.stub(:find_by_code).and_return Factory(:discipline)
      end

      it "generates the best timetable" do
        BestTimetable.should_receive(:generate)
        post :generate, :disciplines => codes
      end

      it "sets the @timetable variable with the best timetable" do
        BestTimetable.stub(:generate).and_return :flag
        post :generate, :disciplines => codes
        assigns[:timetables].should be :flag
      end
    end
  end
end
